import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/posts/states/post_detail.state.dart';

import '../../home/models/post_model.dart';
import '../../profile/models/basic_user.model.dart';


class PostDetailNotifier extends StateNotifier<PostDetailState> {
  PostDetailNotifier() : super(PostDetailState.initial());

  // Establecer el post actual para visualizar o editar
  void setPost(Post post) {
    state = PostDetailState(post);
  }

  // Crear un nuevo post (resetea el estado con el nuevo post)
  void createPost(String title, String content, BasicUser user) {
    final newPost = Post(
      content: content,
      user: user,
      likesCount: 0,
      dislikesCount: 0,
      sharesCount: 0,
    );
    state = PostDetailState(newPost);
  }

  // Actualizar el contenido del post actual
  void updatePostContent(String newContent) {
    state = PostDetailState(
      state.post.copyWith(
        content: newContent,
      ),
    );
  }

  // Eliminar el post actual
  void deletePost() {
    state = PostDetailState.initial();
  }
}
