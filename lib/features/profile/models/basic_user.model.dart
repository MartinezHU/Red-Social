class BasicUser {
  final String uuid;
  final String username;
  final String profilePicUrl;

  BasicUser(
      {required this.uuid,
      required this.username,
      required this.profilePicUrl});

  // Método para convertir un objeto BasicUser en un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'username': username,
      'profile_pic_url': profilePicUrl
    };
  }

  factory BasicUser.fromJson(Map<String, dynamic> json) {
    return BasicUser(
        uuid: json['uuid'],
        username: json['username'],
        profilePicUrl: json['profile_pic_url']);
  }

  factory BasicUser.empty() {
    return BasicUser(
      uuid: '', // ID del usuario vacío
      username: '', // Nombre de usuario vacío o anónimo
      profilePicUrl: '',
    );
  }
}
