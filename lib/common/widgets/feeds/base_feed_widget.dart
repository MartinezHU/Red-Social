import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/common/widgets/feeds/post_base_widget.dart';

import '../../../features/home/models/post_model.dart';
import '../../../features/posts/providers/posts_provider.dart';

class BasePostsFeed extends ConsumerWidget {
  final Widget Function(Post post)? postBuilder;

  const BasePostsFeed({
    this.postBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(postsProvider);
      },
      child: postsAsyncValue.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(child: Text('No posts available.'));
          }
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return postBuilder != null
                  ? postBuilder!(post)
                  : PostBaseWidget(
                      post: post,
                      onTap: () {
                        Navigator.pushNamed(context, '/postDetail',
                            arguments: post.id);
                      },
                    );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
