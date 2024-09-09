import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/auth/screens/auth_check_screen.dart';
import 'package:social_app/features/auth/screens/login_screen.dart';

import './common/themes/app_theme.dart';
import 'features/home/screens/home_screen.dart';
import 'features/posts/screens/post_detail_screen.dart';

void main() async {
  // Asegúrate de cargar el archivo .env antes de inicializar la app
  await dotenv.load();
  // Configurar la visibilidad del sistema para que siempre sea visible
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // const titleTxtColor = Color(0xFF4B5563);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Changelogr',
      theme: buildAppTheme(),
      home: const AuthCheckScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/postDetail': (context) => PostDetailScreen(
            postId: ModalRoute.of(context)?.settings.arguments as int),
      },
    );
  }
}
