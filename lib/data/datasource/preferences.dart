import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const keyThemeMode = 'theme_mode';
  final defThemeMode = ThemeMode.light.index;

  final SharedPreferences prefs;

  Preferences({required this.prefs});

  Future<int> getThemeMode() async {
    return prefs.getInt(keyThemeMode) ?? defThemeMode;
  }

  Future<void> setThemeMode(int value) async {
    await prefs.setInt(keyThemeMode, value);
  }
}
