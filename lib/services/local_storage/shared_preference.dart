import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  const LocalStorageService();

  static final provider = Provider<LocalStorageService>(
    (ref) => const LocalStorageService(),
  );

  Future<void> saveToDisk<T>(String key, T content) async {
    final preferences = await SharedPreferences.getInstance();
    if (content is String) {
      await preferences.setString(key, content);
    }
    if (content is bool) {
      await preferences.setBool(key, content);
    }
    if (content is int) {
      await preferences.setInt(key, content);
    }
    if (content is double) {
      await preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      await preferences.setStringList(key, content);
    }
  }

  Future<Object?> getFromDisk(String key) async {
    final preferences = await SharedPreferences.getInstance();
    final value = preferences.get(key);
    return value;
  }

  Future<bool> removeFromDisk(String key) async {
    final preferences = await SharedPreferences.getInstance();
    final value = await preferences.remove(key);
    return value;
  }
}