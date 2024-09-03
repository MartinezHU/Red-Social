
import '../../home/models/post_model.dart';

class PostsState {
  final List<Post> posts;

  PostsState(this.posts);

  // Estado inicial vacío
  factory PostsState.initial() {
    return PostsState([]);
  }
}
