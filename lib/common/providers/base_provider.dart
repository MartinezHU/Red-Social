import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/common/services/base_service.dart';

class BaseProvider<T extends BaseService> {
  static const String baseUrl = 'http://10.0.2.2:8000';
  BaseProvider();
}

Provider<T> createServiceProvider<T extends BaseService>(T Function(String) constructor) {
  return Provider<T>((ref) {
    return constructor(BaseProvider.baseUrl);
  });
}