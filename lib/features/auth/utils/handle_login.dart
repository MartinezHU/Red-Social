import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/auth/providers/auth_provider.dart';
import 'package:social_app/features/auth/utils/login_credentials.dart';

Future<void> handleLogin(
  BuildContext context,
  WidgetRef ref,
  String username,
  String password,
) async {
  try {
    final loginCredentials =
        LoginCredentials(username: username, password: password);
    final authResponse = await ref.read(loginProvider(loginCredentials).future);

    final storage = ref.read(tokenStorageProvider);
    storage.saveAccessToken(authResponse.accessToken);
    storage.saveRefreshToken(authResponse.refreshToken);

    // Preguntar si el usuario quiere habilitar la biometría

    bool? enableBiometrics = false;

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
              ));
    }

    if (enableBiometrics != null) {
      await ref.read(authServiceProvider).enableBiometrics(true);
    }

    //Navegar hacia la página principal
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  } catch (err) {
    // Maneja errores aquí
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed: $err')));
    }
  }
}
