import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/common/utils/config.dart';
import 'package:social_app/features/home/models/post_model.dart';

import '../services/posts_service.dart';
import '../states/post_detail.state.dart';
import '../states/post_detail_notifier.dart';

String apiUrl = EnvConfig.apiUrl;

final postsServiceProvider = Provider<PostsService>((ref) {
  return PostsService('$apiUrl/posts/posts');
});

// Cambia esto a StateNotifierProvider
final postDetailProvider =
    StateNotifierProvider<PostDetailNotifier, PostDetailState>((ref) {
  final postsService = ref.watch(postsServiceProvider);
  return PostDetailNotifier(postsService);
});

final postsProvider = FutureProvider<List<Post>>((ref) async {
  final postsService = ref.watch(postsServiceProvider);
  return postsService.getAll();
});

final postDetailFutureProvider =
    FutureProvider.family<Post, int>((ref, postId) async {
  final postsService = ref.watch(postsServiceProvider);
  return postsService.getById(postId);
});

final postCreateFutureProvider = FutureProvider.family<Post, Post>((ref, post) {
  final postsService = ref.watch(postsServiceProvider);
  return postsService.create(post);
});
