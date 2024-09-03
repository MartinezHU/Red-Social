import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

final key = encrypt.Key.fromUtf8('YFk^tnAf7x^2NaD&');
final encrypter = encrypt.Encrypter(encrypt.AES(key)); // Usa una clave segura
final iv = encrypt.IV.fromLength(16); // Vector de inicialización

class TokenStorage {
  final FlutterSecureStorage _storage;

  TokenStorage(this._storage);

  String encryptToken(String token) {
    return encrypter.encrypt(token, iv: iv).base64;
  }

  String decryptToken(String encryptedToken) {
    return encrypter.decrypt64(encryptedToken, iv: iv);
  }

// Guardar tokens
  Future<void> saveAccessToken(String accessToken) async {
    final encryptedAccessToken = encryptToken(accessToken);
    await _storage.write(key: 'access_token', value: encryptedAccessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    final encryptedRefreshToken = encryptToken(refreshToken);
    await _storage.write(key: 'refresh_token', value: encryptedRefreshToken);
  }

// Leer el token
  Future<String?> getAccessToken() async {
    final encryptedToken = await _storage.read(key: 'access_token');
    return encryptedToken != null ? decryptToken(encryptedToken) : null;
  }

  Future<String?> getRefreshToken() async {
    final encryptedToken = await _storage.read(key: 'refresh_token');
    return encryptedToken != null ? decryptToken(encryptedToken) : null;
  }

// Eliminar tokens
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: 'access_token');
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: 'refresh_token');
  }
}
