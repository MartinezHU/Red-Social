import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/posts/screens/edit_or_create_post_screen.dart';

import '../../../common/widgets/feeds/post_base_detail_widget.dart';
import '../providers/posts_provider.dart';

class PostDetailScreen extends ConsumerWidget {
  final int postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postDetailAsyncValue = ref.watch(postDetailFutureProvider(postId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Post'),
        actions: [
          postDetailAsyncValue.when(
            data: (post) => IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditOrCreatePostScreen(post: post),
                  ),
                );
              },
            ),
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: postDetailAsyncValue.when(
        data: (post) => PostBaseDetailWidget(post: post),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: ${error.toString()}')),
      ),
    );
  }
}
