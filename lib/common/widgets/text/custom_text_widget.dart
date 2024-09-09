import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String data;

  const CustomTextWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var screenWidth =
        MediaQuery.of(context).size.width; // Obtiene el ancho de la pantalla

    return Text(
      data,
      style: TextStyle(
        fontSize: screenWidth > 600 ? 24 : 16, // Fuente ajustable
      ),
    );
  }
}
