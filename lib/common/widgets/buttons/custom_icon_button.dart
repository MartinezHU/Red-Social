import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double? size;

  const CustomIconButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.color = Colors.white,
      this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    var screenWidth =
        MediaQuery.of(context).size.width; // Obtiene el ancho de la pantalla

    return IconButton(
      icon: Icon(icon, color: color, size: size),
      iconSize: screenWidth > 600 ? 40 : 24,
      onPressed: onPressed,
    );
  }
}
