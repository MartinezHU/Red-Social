class BasicUser {
  final String uuid;
  final String username;
  final String profilePic;

  BasicUser(
      {required this.uuid, required this.username, required this.profilePic});

  // Método para convertir un objeto BasicUser en un mapa JSON
  Map<String, dynamic> toJson() {
    return {'uuid': uuid, 'username': username, 'profile_pic': profilePic};
  }

  factory BasicUser.fromJson(Map<String, dynamic> json) {
    return BasicUser(
        uuid: json['uuid'],
        username: json['username'],
        profilePic: json['profile_pic']);
  }

  factory BasicUser.empty() {
    return BasicUser(
      uuid: '', // ID del usuario vacío
      username: '', // Nombre de usuario vacío o anónimo
      profilePic: '',
    );
  }
}
