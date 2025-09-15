import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String kAccessToken     = 'accessToken';
  static const String kUserLoginId     = 'userLoginId';
  static const String kIsLoggedIn      = 'isLoggedIn';
  static const String kIsPhoneVerified = 'isPhoneVerified';

  static Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  static Future<void> setString(String key, String value) async {
    final p = await _prefs();
    await p.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final p = await _prefs();
    return p.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    final p = await _prefs();
    await p.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final p = await _prefs();
    return p.getBool(key);
  }

  static Future<void> setJson(String key, Map<String, dynamic> value) async {
    final p = await _prefs();
    await p.setString(key, jsonEncode(value));
  }

  static Future<Map<String, dynamic>?> getJson(String key) async {
    final p = await _prefs();
    final s = p.getString(key);
    if (s == null) return null;
    try {
      return jsonDecode(s) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<void> saveAccessToken(String token) =>
      setString(kAccessToken, token);

  static Future<String?> getAccessToken() =>
      getString(kAccessToken);

  static Future<void> saveUserLoginId(String id) =>
      setString(kUserLoginId, id);

  static Future<String?> getUserLoginId() =>
      getString(kUserLoginId);

  static Future<void> clear() async {
    final p = await _prefs();
    await p.clear();
  }
}
