import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/profile/models/basic_user.model.dart';

import '../../home/models/post_model.dart';
import '../providers/posts_provider.dart';

class EditOrCreatePostWidget extends ConsumerStatefulWidget {
  final Post? post;

  const EditOrCreatePostWidget({super.key, this.post});

  @override
  EditOrCreatePostWidgetState createState() => EditOrCreatePostWidgetState();
}

class EditOrCreatePostWidgetState
    extends ConsumerState<EditOrCreatePostWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Si hay un post, inicializamos el controlador con el contenido del post
    _controller = TextEditingController(text: widget.post?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Contenido del Post',
              border: OutlineInputBorder(),
            ),
            maxLines: 10,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final content = _controller.text;
              if (content.isEmpty) return;

              if (widget.post?.id == null) {
                // Crear nuevo post
                final newPost = Post(
                    user: BasicUser.empty(),
                    content: content,
                    likesCount: 0,
                    dislikesCount: 0,
                    commentsCount: 0,
                    sharesCount: 0);
                await ref.read(postsServiceProvider).create(newPost);
              } else {
                // Editar post existente

                // await ref.read(postsServiceProvider).update();
              }

              // Volver a la pantalla anterior
              Navigator.pop(context);
            },
            child: Text(
                widget.post?.id == null ? 'Crear Post' : 'Actualizar Post'),
          ),
        ],
      ),
    );
  }
}
