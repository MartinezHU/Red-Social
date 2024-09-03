import 'package:social_app/features/home/models/post_model.dart';

import '../../../../common/services/base_service.dart';

class PostsService extends BaseService<Post> {
  PostsService(String baseUrl)
      : super(baseUrl: baseUrl, fromJson: Post.fromJson);
}
