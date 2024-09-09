import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:social_app/features/auth/providers/auth_provider.dart';
import 'package:social_app/features/auth/utils/login_credentials.dart';

import '../../../common/utils/shared_preferences.dart';

Future<void> handleLogin(BuildContext context, WidgetRef ref, String username,
    String password) async {
  try {
    final loginCredentials =
        LoginCredentials(username: username, password: password);
    final authResponse = await ref.read(loginProvider(loginCredentials).future);

    final storage = ref.read(tokenStorageProvider);
    storage.saveAccessToken(authResponse.accessToken);
    storage.saveRefreshToken(authResponse.refreshToken);

    final PreferencesService preferences = PreferencesService();

    // Verificar si la biometría está habilitada
    final bool hasBiometricsPreference =
        await preferences.getBiometricsPreference();

    // Verificar la disponibilidad de la biometría en el dispositivo
    bool biometricsAvailableAndHasData =
        await _isBiometricsAvailableAndHasData();

    if (biometricsAvailableAndHasData) {
      if (!hasBiometricsPreference) {
        bool? enableBiometrics = false;

        // Preguntar si el usuario quiere habilitar la biometría
        if (context.mounted) {
          enableBiometrics = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Habilitar biometría'),
              content: const Text(
                  '¿Quieres usar la autenticación biométrica para futuros inicios de sesión?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Sí'),
                )
              ],
            ),
          );
        }

        if (enableBiometrics != null) {
          if (enableBiometrics) {
            bool biometricsAuthenticated = await ref
                .read(authServiceProvider)
                .authenticateWithBiometrics();
            if (biometricsAuthenticated) {
              // Guardar la preferencia de habilitación de biometría
              await preferences.saveBiometricsPreference(true);
            } else {
              // Manejar el caso en que la autenticación biométrica falla
              // Por ejemplo, podrías mostrar un mensaje o intentar de nuevo
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Autenticación biométrica fallida.')),
                );
                Navigator.pushReplacementNamed(context, '/login');
              }
              // No guardar la preferencia si la autenticación falla
            }
          } else {
            // Guardar la preferencia de biometría como false si el usuario elige no habilitarla
            await preferences.saveBiometricsPreference(false);
          }
        }
      } else {
        // La preferencia ya está guardada, así que no se pregunta nuevamente
        final bool biometricsEnabled =
            await preferences.getBiometricsPreference();
        if (biometricsEnabled) {
          bool biometricsAuthenticated =
              await ref.read(authServiceProvider).authenticateWithBiometrics();
          if (!biometricsAuthenticated) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Autenticación biométrica fallida.')),
              );
            }
            // Manejar la falla en la autenticación biométrica, tal vez solicitar inicio de sesión nuevamente
          }
        }
      }
    }

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  } catch (err) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed: $err')));
    }
  }
}

Future<bool> _isBiometricsAvailableAndHasData() async {
  try {
    final LocalAuthentication auth = LocalAuthentication();

    // Verificar soporte de biometría y si hay datos registrados
    bool isBiometricSupported = await auth.canCheckBiometrics;
    if (!isBiometricSupported) return false;

    List<BiometricType> biometrics = await auth.getAvailableBiometrics();
    return biometrics.isNotEmpty;
  } catch (error) {
    throw Exception(error);
  }
}
