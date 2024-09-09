import 'package:flutter/material.dart';
import 'package:social_app/common/widgets/avatar/custom_avatar_widget.dart';
import 'package:social_app/common/widgets/buttons/custom_icon_button.dart';
import 'package:social_app/common/widgets/content/custom_widget_content.dart';
import 'package:social_app/common/widgets/text/custom_text_widget.dart';

import '../../../features/home/models/post_model.dart';

class PostBaseWidget extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostBaseWidget({required this.post, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Perfil e información de usuario
              Row(
                children: [
                  CustomAvatarWidget(image: post.user.profilePicUrl),
                  const SizedBox(width: 10),
                  CustomTextWidget(data: post.user.username),
                ],
              ),
              const SizedBox(height: 10),
              // Contenido del post
              CustomWidgetContent(
                text: post.content,
                images: post.images,
              ),
              const SizedBox(height: 10),
              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomIconButton(
                        icon: Icons.thumb_up,
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                      Text(post.likesCount.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      CustomIconButton(
                        icon: Icons.thumb_down,
                        color: Colors.red,
                        onPressed: () {},
                      ),
                      Text(post.dislikesCount.toString()),
                    ],
                  ),
                  CustomIconButton(
                    icon: Icons.comment,
                    onPressed: () {},
                  ),
                  CustomIconButton(
                    icon: Icons.share,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
