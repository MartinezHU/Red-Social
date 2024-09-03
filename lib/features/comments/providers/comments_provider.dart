import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/common/utils/config.dart';
import 'package:social_app/features/comments/services/comments_service.dart';

String apiUrl = EnvConfig.apiUrl;

final commentsServiceProvider = Provider<CommentsService>((ref) {
  return CommentsService('$apiUrl/comments/comments');
});
