import '../screens/post_detail_screen.dart';

final postRoutes = {
  '/postDetail': (context, {int? postId}) => PostDetailScreen(postId: postId!),
  // '/myFeed': (context) => PostDetailScreen(postId: null,),
};
