import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:social_app/features/auth/models/auth_response.dart';
import 'package:social_app/features/auth/services/auth_service.dart';
import 'package:social_app/features/auth/utils/tokens_storage.dart';

import '../../../common/utils/config.dart';
import '../utils/login_credentials.dart';

String apiUrl = EnvConfig.apiUrl;

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final storage = ref.watch(flutterSecureStorageProvider);
  return TokenStorage(storage);
});

final localAuthProvider = Provider<LocalAuthentication>((ref) {
  return LocalAuthentication();
});

final authServiceProvider = Provider<AuthService>((ref) {
  final storage = ref.watch(tokenStorageProvider);
  final auth = ref.watch(localAuthProvider);
  return AuthService(apiUrl, storage, auth);
});

// Otros proveedores relacionados con autenticación

final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.isLoggedIn();
});

final isBiometricEnabledProvider = FutureProvider<bool>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.isBiometricEnabled();
});

final loginProvider =
    FutureProvider.family<AuthResponse, LoginCredentials>((ref, credentials) {
  final authService = ref.watch(authServiceProvider);
  return authService.loginWithCredentials(
      credentials.username, credentials.password);
});
