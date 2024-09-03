import 'package:social_app/common/models/entity.model.dart';
import 'package:social_app/features/profile/models/basic_user.model.dart';

class Comment extends BaseEntity {
  final BasicUser user;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Comment(
      {super.id,
      required this.user,
      required this.content,
      this.createdAt,
      this.updatedAt});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user: BasicUser.fromJson(json['user']),
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'content': content,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Comment copyWith({
    int? id,
    BasicUser? user,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Comment(
      id: id ?? this.id,
      user: user ?? this.user,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
