// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:social_app/common/widgets/feeds/post_widget.dart';
//
// import '../../home/models/post_model.dart';
//
// class PostDetailWidget extends ConsumerWidget {
//   final Widget Function(Post post)? postBuilder;
//   final Post post;
//
//   const PostDetailView({this.postBuilder, super.key, required this.post});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return postBuilder != null
//         ? postBuilder!(post)
//         : PostWidget(
//             post: post,
//           );
//   }
// }
