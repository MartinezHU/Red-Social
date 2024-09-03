import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/common/widgets/feeds/post_base_widget.dart';
import '../../../../common/widgets/feeds/base_feed_widget.dart';

class PostsHomeFeed extends ConsumerWidget {
  const PostsHomeFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Feed'),
      // ),
      body: BasePostsFeed(
        postBuilder: (post) {
          return PostBaseWidget(
            post: post,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/postDetail',
                arguments: post.id,
              );
            },
          );
        },
      ),
    );
  }
}
