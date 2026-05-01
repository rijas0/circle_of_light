import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class QuranAuthService {
  static final QuranAuthService _instance = QuranAuthService._internal();
  factory QuranAuthService() => _instance;
  QuranAuthService._internal();

  final _appAuth = FlutterAppAuth();
  final _storage = const FlutterSecureStorage();

  // Prelive Configuration
  static const _clientId = 'b90f5393-b76b-41dd-bdd8-b7c738536464';
  static const _redirectUri = 'dayira://quran-login';
  static const _issuer = 'https://prelive-oauth2.quran.foundation';

  Future<String?> login() async {
    try {
      // 1. Initiate Authorization
      final AuthorizationResponse? result = await _appAuth.authorize(
        AuthorizationRequest(
          _clientId,
          _redirectUri,
          issuer: _issuer,
          scopes: ['openid', 'profile', 'email', 'read:bookmarks'],
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: '$_issuer/oauth/authorize',
            tokenEndpoint: '$_issuer/oauth/token',
          ),
          allowInsecureConnections: false,
        ),
      );

      if (result != null) {
        final code = result.authorizationCode;
        if (code != null) {
          print('Authorization Code received: $code');
          return code;
        } else {
          print('Login cancelled or failed.');
          return null;
        }
      }
      return null;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  Future<void> saveToken(String accessToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'access_token');
  }
}
