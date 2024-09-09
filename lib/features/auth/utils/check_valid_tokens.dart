import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:social_app/features/auth/utils/tokens_storage.dart';

import '../../../common/utils/shared_preferences.dart';
import '../providers/auth_provider.dart';

Future<bool> hasValidTokens(TokenStorage tokenStorage, WidgetRef ref) async {
  final accessToken = await tokenStorage.getAccessToken();
  final refreshToken = await tokenStorage.getRefreshToken();

  // Si no hay tokens de acceso ni de refresco, no hay tokens válidos
  if (accessToken == null || refreshToken == null) {
    return false;
  }

  // Verificar si el token de acceso ha expirado
  if (isTokenExpired(accessToken)) {
    try {
      // Llamar al provider para refrescar el token
      await ref.read(refreshTokenProvider
          .future); // Asegúrate de usar .future para obtener el Future

      // Después de refrescar, verificar si el token de acceso se ha renovado
      final newAccessToken = await tokenStorage.getAccessToken();
      if (newAccessToken == null || isTokenExpired(newAccessToken)) {
        return false;
      }
    } catch (error) {
      // Manejar cualquier error durante el refresco del token
      return false;
    }
  }

  return true;
}

bool isTokenExpired(String token) {
  try {
    final jwt = JWT.decode(token);
    final exp = jwt.payload['exp'] as int;
    final now =
        DateTime.now().millisecondsSinceEpoch ~/ 1000; // Convert to seconds
    return exp < now;
  } catch (e) {
    // Manejar errores de decodificación
    return true;
  }
}

// Para comprobar y refrescar el token de acceso.
Future<void> checkAndHandleAuth(WidgetRef ref, BuildContext context) async {
  try {
    final LocalAuthentication auth = LocalAuthentication();
    final tokenStorage = ref.read(tokenStorageProvider);
    final PreferencesService preferences = PreferencesService();

    // Verificar si hay tokens válidos y refrescarlos si es necesario
    bool tokensValid = await hasValidTokens(tokenStorage, ref);

    if (!tokensValid) {
      // Redirigir a la pantalla de inicio de sesión si los tokens no son válidos
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
      return;
    }

    // Verificar la preferencia de biometría
    final bool biometricsEnabled = await preferences.getBiometricsPreference();
    final bool biometricsAvailable = await auth.canCheckBiometrics;
    final bool hasBiometricData = await auth
        .getAvailableBiometrics()
        .then((biometrics) => biometrics.isNotEmpty);

    if (biometricsEnabled && biometricsAvailable && hasBiometricData) {
      // Intentar autenticación biométrica
      bool authenticated =
          await ref.read(authServiceProvider).authenticateWithBiometrics();
      if (authenticated) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    } else {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  } catch (e) {
    // Manejo de errores, redirige a la pantalla de inicio de sesión en caso de error
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
