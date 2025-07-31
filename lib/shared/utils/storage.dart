import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language_code';
  static const String _userDataKey = 'user_data';

  static Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  static Future<void> clearTokens() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  static Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> saveThemeMode(String themeMode) async {
    final prefs = await _prefs;
    await prefs.setString(_themeKey, themeMode);
  }

  static Future<String?> getThemeMode() async {
    final prefs = await _prefs;
    return prefs.getString(_themeKey);
  }

  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await _prefs;
    await prefs.setString(_languageKey, languageCode);
  }

  static Future<String?> getLanguage() async {
    final prefs = await _prefs;
    return prefs.getString(_languageKey);
  }

  static Future<void> saveUserData(String userData) async {
    final prefs = await _prefs;
    await prefs.setString(_userDataKey, userData);
  }

  static Future<String?> getUserData() async {
    final prefs = await _prefs;
    return prefs.getString(_userDataKey);
  }

  static Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    final prefs = await _prefs;
    await prefs.clear();
  }

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
