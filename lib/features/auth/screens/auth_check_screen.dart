import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/check_valid_tokens.dart';

class AuthCheckScreen extends ConsumerWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<void>(
      future: checkAndHandleAuth(ref, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // No es necesario manejar el resultado aquí porque la navegación se ha manejado en `checkAndHandleAuth`
          // Solo comprobamos si hay errores
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Mostrar un widget vacío mientras se maneja la navegación
          return Container();
        }
      },
    );
  }
}
