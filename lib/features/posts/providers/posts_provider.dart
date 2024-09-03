import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/common/utils/config.dart';
import 'package:social_app/features/home/models/post_model.dart';

import '../services/posts_service.dart';

String apiUrl = EnvConfig.apiUrl;

final postsServiceProvider = Provider<PostsService>((ref) {
  return PostsService('$apiUrl/posts/posts');
});

final postsProvider = FutureProvider<List<Post>>((ref) async {
  final postsService = ref.watch(postsServiceProvider);
  return postsService.getAll();
});

final postDetailProvider =
    FutureProvider.family<Post, int>((ref, postId) async {
  final postsService = ref.watch(postsServiceProvider);
  return postsService.getById(postId);
});
