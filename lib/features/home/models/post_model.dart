import 'package:social_app/common/models/entity.model.dart';
import 'package:social_app/features/home/models/post_image.dart';
import 'package:social_app/features/profile/models/basic_user.model.dart';

import '../../../common/exceptions/invalid_model_exception.dart';

class Post extends BaseEntity {
  final BasicUser user;
  late final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int likesCount;
  final int dislikesCount;
  final int commentsCount;
  final int sharesCount;
  final List<PostImage>? images;

  Post(
      {super.id,
      required this.user,
      required this.content,
      this.createdAt,
      this.updatedAt,
      required this.likesCount,
      required this.dislikesCount,
      required this.commentsCount,
      required this.sharesCount,
      this.images});

  factory Post.fromJson(Map<String, dynamic> json) {
    // Validar antes de crear el objeto
    validateModelFields({
      'user': json['user'],
      'content': json['content'],
      'likesCount': json['likes_count'],
      'dislikesCount': json['dislikes_count'],
      'commentsCount': json['comments_count'],
      'sharesCount': json['shares_count'],
    });

    return Post(
      id: json['id'],
      user: BasicUser.fromJson(json['user']),
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      likesCount: json['likes_count'],
      dislikesCount: json['dislikes_count'],
      commentsCount: json['comments_count'],
      sharesCount: json['shares_count'],
      images: (json['images'] as List<dynamic>)
          .map((image) => PostImage.fromJson(image))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'user': user.toJson(),
      // Convertir el objeto BasicUser a JSON
      'createdAt': createdAt?.toIso8601String(),
      // Convertir DateTime a String si no es null
      'updatedAt': updatedAt?.toIso8601String(),
      // Convertir DateTime a String si no es null
      'likesCount': likesCount,
      'dislikesCount': dislikesCount,
      // 'commentsCount': commentsCount,
      'sharesCount': sharesCount,
      'images': images,
    };
  }

  Post copyWith({
    int? id,
    String? content,
    BasicUser? user,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likesCount,
    int? dislikesCount,
    int? commentsCount,
    int? sharesCount,
    List<PostImage>? images,
  }) {
    return Post(
      id: id ?? this.id,
      content: content ?? this.content,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likesCount: likesCount ?? this.likesCount,
      dislikesCount: dislikesCount ?? this.dislikesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      images: images ?? this.images,
    );
  }
}
