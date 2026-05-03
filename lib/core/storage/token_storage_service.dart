import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  final FlutterSecureStorage _storage;

  TokenStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );

  static const _keyAccessToken = 'access_token';
  static const _keyUserId = 'user_id';
  static const _keyUserEmail = 'user_email';
  static const _keyUserName = 'user_name';
  static const _keyUserRole = 'user_role';
  static const _keyUserAvatar = 'user_avatar';
  static const _keyUserCreatedAt = 'user_created_at';

  Future<void> saveTokens({
    required String accessToken,
    required String userId,
    required String email,
    required String name,
    required String role,
    required String avatarUrl,
    required String createdAt,
  }) async {
    await Future.wait([
      _storage.write(key: _keyAccessToken, value: accessToken),
      _storage.write(key: _keyUserId, value: userId),
      _storage.write(key: _keyUserEmail, value: email),
      _storage.write(key: _keyUserName, value: name),
      _storage.write(key: _keyUserRole, value: role),
      _storage.write(key: _keyUserAvatar, value: avatarUrl),
      _storage.write(key: _keyUserCreatedAt, value: createdAt),
    ]);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: _keyAccessToken);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, String?>> getUserData() async {
    final results = await Future.wait([
      _storage.read(key: _keyUserId),
      _storage.read(key: _keyUserEmail),
      _storage.read(key: _keyUserName),
      _storage.read(key: _keyUserRole),
      _storage.read(key: _keyUserAvatar),
      _storage.read(key: _keyUserCreatedAt),
    ]);
    return {
      'id': results[0],
      'email': results[1],
      'name': results[2],
      'role': results[3],
      'avatarUrl': results[4],
      'createdAt': results[5],
    };
  }

  Future<void> clearTokens() async {
    await _storage.deleteAll();
  }
}
