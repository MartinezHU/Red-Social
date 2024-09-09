import 'package:social_app/features/home/models/post_model.dart';

import '../../profile/models/basic_user.model.dart';

class PostDetailState {
  final Post post;

  PostDetailState(this.post);

  // Estado inicial sin un post seleccionado
  factory PostDetailState.initial() {
    return PostDetailState(Post(
      id: 0,
      user: BasicUser.empty(),
      content: '',
      createdAt: null,
      updatedAt: null,
      likesCount: 0,
      dislikesCount: 0,
      commentsCount: 0,
      sharesCount: 0,
    ));
  }
}
