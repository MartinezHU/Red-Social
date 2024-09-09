import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/posts/widgets/edit_or_create_post_widget.dart';

import '../../home/models/post_model.dart';

class EditOrCreatePostScreen extends ConsumerWidget {
  final Post? post;

  const EditOrCreatePostScreen({super.key, this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post?.id == null ? 'Crear Nuevo Post' : 'Editar Post'),
      ),
      body: EditOrCreatePostWidget(
        post: post,
      ),
    );
  }
}
