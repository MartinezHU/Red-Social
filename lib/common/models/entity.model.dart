import '../interfaces/json_serializable.dart';

abstract class BaseEntity implements JsonSerializable {
  final int? id;

  BaseEntity({this.id});

  @override
  Map<String, dynamic> toJson();

  factory BaseEntity.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
