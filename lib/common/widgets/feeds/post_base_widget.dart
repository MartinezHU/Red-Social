import 'package:flutter/material.dart';

import '../../../features/home/models/post_model.dart';

class PostBaseWidget extends StatelessWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostBaseWidget({required this.post, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final truncatedContent = post.content.length > 200
        ? '${post.content.substring(0, 200)}...'
        : post.content;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.user.profilePic),
            ),
            title: Text(truncatedContent),
            subtitle: Text(
              'Likes: ${post.likesCount} | Dislikes: ${post.dislikesCount} | Shares: ${post.sharesCount}',
            ),
            onTap: onTap,
          ),
          if (post.images != null && post.images!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: post.images!.length,
                  itemBuilder: (context, imageIndex) {
                    final imageUrl = post.images![imageIndex].image;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Image.network(
                        imageUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
