import 'package:social_app/features/comments/models/comment_model.dart';

import '../../../../common/services/base_service.dart';

class CommentsService extends BaseService<Comment> {
  CommentsService(String baseUlr)
      : super(baseUrl: baseUlr, fromJson: Comment.fromJson);
}
