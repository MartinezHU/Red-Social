import 'package:flutter/material.dart';
import 'package:social_app/common/widgets/text/custom_text_widget.dart';
import 'package:social_app/features/home/models/post_image.dart';

import '../../../features/posts/screens/image_detail_screen.dart';

// Widget para mostrar el contenido del post
class CustomWidgetContent extends StatelessWidget {
  final String? text; // Texto opcional
  final List<PostImage>? images; // Lista de URLs de imágenes opcionales

  const CustomWidgetContent({
    super.key,
    this.text, // Texto que puede ser null
    this.images, // Imágenes que pueden ser null o vacías
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Alinea el contenido a la izquierda
      children: [
        // Mostrar texto solo si existe
        if (text != null && text!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            // Espacio debajo del texto
            child: CustomTextWidget(data: text!),
          ),

        // Mostrar imágenes solo si hay imágenes
        if (images != null && images!.isNotEmpty)
          // Usamos un GridView para mostrar las imágenes en cuadrícula
          GridView.builder(
            shrinkWrap: true,
            // Permite que el GridView se ajuste a su contenido
            physics: const NeverScrollableScrollPhysics(),
            // Desactiva el scroll en el GridView
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de columnas
              crossAxisSpacing: 8.0, // Espaciado entre columnas
              mainAxisSpacing: 8.0, // Espaciado entre filas
              childAspectRatio: 1.0, // Relación de aspecto 1:1 para cuadrículas
            ),
            itemCount: images!.length,
            // Número de imágenes a mostrar
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () =>
                    _navigateToImageDetailScreen(context, images![index].image),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  // Bordes redondeados
                  child: Image.network(
                    images![index].image, // URL de la imagen
                    fit:
                        BoxFit.cover, // Cubrir todo el espacio de la cuadrícula
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

// Función para mostrar la imagen en una pantalla dedicada
void _navigateToImageDetailScreen(BuildContext context, String imageUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ImageDetailScreen(imageUrl: imageUrl),
    ),
  );
}
