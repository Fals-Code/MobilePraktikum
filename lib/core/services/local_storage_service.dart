import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _tokenKey      = 'auth_token';
  static const String _userIdKey     = 'user_id';
  static const String _usernameKey   = 'username';
  static const String _savedUsersKey = 'saved_users';

  // — Token —
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // — User —
  Future<void> saveUser({
    required String userId,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_usernameKey, username);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // — Simpan user ke list (default key) —
  Future<void> addUserToSavedList({
    required String userId,
    required String username,
  }) async {
    await addUserToSavedListWithKey(
      key:      _savedUsersKey,
      userId:   userId,
      username: username,
    );
  }

  Future<List<Map<String, String>>> getSavedUsers() async {
    return getSavedUsersWithKey(_savedUsersKey);
  }

  Future<void> removeSavedUser(String userId) async {
    await removeSavedUserWithKey(_savedUsersKey, userId);
  }

  Future<void> clearSavedUsers() async {
    await clearSavedUsersWithKey(_savedUsersKey);
  }

  // — Generic method dengan custom key (untuk mahasiswa, dosen, dll) —
  Future<void> addUserToSavedListWithKey({
    required String key,
    required String userId,
    required String username,
  }) async {
    final prefs   = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(key) ?? [];

    final isDuplicate = rawList.any((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    if (isDuplicate) return;

    final newUser = jsonEncode({
      'user_id':  userId,
      'username': username,
      'saved_at': DateTime.now().toIso8601String(),
    });

    rawList.add(newUser);
    await prefs.setStringList(key, rawList);
  }

  Future<List<Map<String, String>>> getSavedUsersWithKey(String key) async {
    final prefs   = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(key) ?? [];

    return rawList.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return {
        'user_id':  (map['user_id']  ?? '').toString(),
        'username': (map['username'] ?? '').toString(),
        'saved_at': (map['saved_at'] ?? '').toString(),
      };
    }).toList();
  }

  Future<void> removeSavedUserWithKey(String key, String userId) async {
    final prefs   = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(key) ?? [];

    rawList.removeWhere((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    await prefs.setStringList(key, rawList);
  }

  Future<void> clearSavedUsersWithKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // — Clear All —
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}