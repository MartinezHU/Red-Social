import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/posts/states/post_detail.state.dart';

import '../../home/models/post_model.dart';
import '../services/posts_service.dart';

class PostDetailNotifier extends StateNotifier<PostDetailState> {
  final PostsService _postsService;

  PostDetailNotifier(this._postsService) : super(PostDetailState.initial());

  // Establecer el post actual para visualizar o editar
  void setPost(Post post) {
    state = PostDetailState(post);
  }

  // Crear un nuevo post (resetea el estado con el nuevo post)
  Future<void> createPost(Post post) async {
    try {
      final newPost = await _postsService.create(post);
      state = PostDetailState(newPost);
    } catch (error) {
      throw Exception('Failed to create post');
    }
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
