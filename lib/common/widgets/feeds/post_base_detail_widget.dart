import 'package:flutter/material.dart';

import '../../../features/home/models/post_model.dart';

class PostBaseDetailWidget extends StatelessWidget {
  final Post post;

  const PostBaseDetailWidget({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            if (post.images != null && post.images!.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: post.images!.length,
                  itemBuilder: (context, index) {
                    final imageUrl = post.images![index].image;
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
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.thumb_up, color: Colors.blue),
                const SizedBox(width: 4.0),
                Text('${post.likesCount} Likes'),
                const SizedBox(width: 16.0),
                const Icon(Icons.thumb_down, color: Colors.red),
                const SizedBox(width: 4.0),
                Text('${post.dislikesCount} Dislikes'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
