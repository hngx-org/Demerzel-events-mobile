import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  const LocalStorageService();

  static final provider = Provider<LocalStorageService>(
    (ref) => const LocalStorageService(),
  );

  Future<void> saveToDisk<T>(String key, T content) async {
    final _preferences = await SharedPreferences.getInstance();
    if (content is String) {
      await _preferences.setString(key, content);
    }
    if (content is bool) {
      await _preferences.setBool(key, content);
    }
    if (content is int) {
      await _preferences.setInt(key, content);
    }
    if (content is double) {
      await _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      await _preferences.setStringList(key, content);
    }
  }

  Future<Object?> getFromDisk(String key) async {
    final _preferences = await SharedPreferences.getInstance();
    final value = _preferences.get(key);
    return value;
  }

  Future<bool> removeFromDisk(String key) async {
    final _preferences = await SharedPreferences.getInstance();
    final value = await _preferences.remove(key);
    return value;
  }
}