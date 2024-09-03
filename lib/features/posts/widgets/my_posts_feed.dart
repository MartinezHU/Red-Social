import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/posts_provider.dart';

class MyPersonalFeed extends ConsumerWidget {
  const MyPersonalFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsProvider);

    return postsAsyncValue.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const Center(child: Text('No posts available.'));
        }
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            // Truncar el contenido del post a 200 caracteres
            final truncatedContent = post.content.length > 200
                ? '${post.content.substring(0, 200)}...' // Añade "..." al final si se trunca
                : post.content;

            return Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/postDetail',
                        arguments: post.id,
                      );
                    },
                  ),
                  // Mostrar las imágenes si el post tiene alguna
                  if (post.images != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 150, // Altura de las imágenes
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // Muestra las imágenes en fila horizontal
                          itemCount: post.images?.length,
                          itemBuilder: (context, imageIndex) {
                            final imageUrl = post.images?[imageIndex].image;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.network(
                                imageUrl!,
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
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
