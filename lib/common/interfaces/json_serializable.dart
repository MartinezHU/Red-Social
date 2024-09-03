abstract class JsonSerializable {
  JsonSerializable();

  Map<String, dynamic> toJson();

  factory JsonSerializable.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
