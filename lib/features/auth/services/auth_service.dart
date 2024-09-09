import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:social_app/common/utils/shared_preferences.dart';
import 'package:social_app/features/auth/models/auth_response.dart';
import 'package:social_app/features/auth/utils/tokens_storage.dart';

class AuthService {
  final String baseUrl;
  final TokenStorage storage;
  final LocalAuthentication auth;
  late final PreferencesService preferences;

  AuthService(this.baseUrl, this.storage, this.auth, this.preferences);

  Future<AuthResponse> loginWithCredentials(
      String username, String password) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/auth/token/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'username': username, 'password': password}));

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Ha ocurrido un error al iniciar sesión');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> isLoggedIn() async {
    String? token = await storage.getAccessToken();
    return token != null ? true : false;
  }

  Future<bool> isBiometricAvailable() async {
    bool biometricStatus = await preferences.getBiometricsPreference();
    return biometricStatus;
  }

  Future<bool> checkBiometricsEnabled() async {
    return await auth
        .getAvailableBiometrics()
        .then((biometrics) => biometrics.isNotEmpty);
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      // Verificar si la biometría está disponible en el dispositivo
      bool isBiometricsAvailable = await auth.canCheckBiometrics;
      if (!isBiometricsAvailable) {
        throw Exception('La biometría no está disponible en este dispositivo.');
      }

      // Solicitar autenticación biométrica
      bool authenticated = await auth.authenticate(
        localizedReason: 'Por favor autentícate para continuar',
        options: const AuthenticationOptions(
          biometricOnly: true, // Solo biometría
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      return authenticated;
    } on PlatformException catch (e) {
      throw Exception('Error con la biometría: ${e.message}');
    } catch (e) {
      throw Exception('Error al autenticar con biometría');
    }
  }

  Future<void> refreshToken() async {
    String? refreshToken = await storage.getRefreshToken();

    if (refreshToken == null) throw Exception('Refresh Token no disponible');

    try {
      final response = await http.post(Uri.parse('$baseUrl/auth/refresh/'),
          headers: {'Authorization': 'Bearer $refreshToken'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await storage.saveAccessToken(data['access']);
      } else {
        await storage.deleteAccessToken();
        // TODO: Comprobar la expiración de los tokens de refresco para obtener uno nuevo dede la API
        // await storage.deleteRefreshToken();
        throw Exception(
            'Refresh token inválido o expirado. El usuario debe volver a autenticarse.');
      }
    } catch (error) {
      // Manejo de errores
      throw Exception('Error al intentar refrescar el token: $error');
    }
  }

  Future<void> handleTokenRefresh() async {
    try {
      String? accessToken = await storage.getAccessToken();

      // Si el accessToken no está disponible, intentar refrescarlo
      if (accessToken == null) {
        await refreshToken();
        accessToken = await storage.getAccessToken();
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/protected-resource'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      // Si el token de acceso ha expirado, intenta refrescarlo
      if (response.statusCode == 401) {
        await refreshToken();

        // Verifica de nuevo el acceso con el nuevo token
        accessToken = await storage.getAccessToken();

        final retryResponse = await http.get(
            Uri.parse('$baseUrl/protected-resource'),
            headers: {'Authorization': 'Bearer $accessToken'});

        if (retryResponse.statusCode != 200) {
          throw Exception(
              'No se pudo acceder al recurso protegido después de intentar refrescar el token.');
        }
      }
    } catch (error) {
      // Manejo de errores y posible reautenticación
      throw Exception('Error al manejar el refresco del token: $error');
    }
  }
}
