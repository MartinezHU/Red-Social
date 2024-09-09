import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage;

  TokenStorage(this._storage);

// Guardar tokens sin encriptación manual, ya están cifrados por FlutterSecureStorage
  Future<void> saveAccessToken(String accessToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

// Leer el token directamente
  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

// Eliminar tokens
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: 'access_token');
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: 'refresh_token');
  }
}
