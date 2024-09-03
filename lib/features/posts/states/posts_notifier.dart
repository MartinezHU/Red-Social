import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/posts/states/posts.state.dart';

import '../../home/models/post_model.dart';


class PostsNotifier extends StateNotifier<PostsState> {
  PostsNotifier() : super(PostsState.initial());

  // Establecer todos los posts (por ejemplo, cuando haces fetch)
  void setPosts(List<Post> posts) {
    state = PostsState(posts);
  }
}
