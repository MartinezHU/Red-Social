import 'package:flutter/material.dart';

class CustomAvatarWidget extends StatelessWidget {
  final String image;

  const CustomAvatarWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    var screenWidth =
        MediaQuery.of(context).size.width; // Obtiene el ancho de la pantalla

    return CircleAvatar(
      radius: screenWidth > 600 ? 40 : 20, // Avatar ajustable
      backgroundImage: NetworkImage(image),
    );
  }
}
