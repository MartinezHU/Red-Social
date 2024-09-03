import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:social_app/features/auth/models/auth_response.dart';
import 'package:social_app/features/auth/utils/tokens_storage.dart';

class AuthService {
  final String baseUrl;
  final TokenStorage storage;
  final LocalAuthentication auth;

  AuthService(this.baseUrl, this.storage, this.auth);

  Future<bool> isLoggedIn() async {
    String? token = await storage.getAccessToken();
    return token != null ? true : false;
  }

  Future<bool> isBiometricEnabled() async {
    String? biometricStatus = await storage.getAccessToken();
    return biometricStatus == 'true';
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await storage.saveRefreshToken(refreshToken);
  }

  Future<bool> authenticateWithBiometrics() async {
    return await auth.authenticate(
      localizedReason: 'Por favor autentícate para continuar',
      options: const AuthenticationOptions(
        biometricOnly: true,
      ),
    );
  }

  Future<AuthResponse> loginWithCredentials(
      String username, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/auth/token/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}));

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> refreshToken() async {
    String? refreshToken = await storage.getRefreshToken();

    if (refreshToken == null) throw Exception('Refresh Token no dispinible');

    final response = await http.post(Uri.parse('$baseUrl/auth/refresh/'),
        headers: {'Authorization': 'Bearer $refreshToken'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await saveRefreshToken(data['access']);
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<void> handleTokenRefresh() async {
    String? accessToken = await storage.getAccessToken();
    if (accessToken == null) throw Exception('Access token no disponible');

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/protected-resource'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 401) {
      await refreshToken();
    }
  }

  Future<void> enableBiometrics(bool enable) async {
    await storage.saveAccessToken(enable ? 'true' : 'false');
  }
}
