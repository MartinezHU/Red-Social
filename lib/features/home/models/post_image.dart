class PostImage {
  final String image;

  PostImage({required this.image});

  // Crear una PostImage desde un JSON
  factory PostImage.fromJson(Map<String, dynamic> json) {
    return PostImage(
      image: json['image'],
    );
  }

  // Convertir una PostImage a JSON
  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }
}
