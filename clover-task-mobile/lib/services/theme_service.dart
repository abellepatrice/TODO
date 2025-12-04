import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class ThemeService extends ChangeNotifier {
  static const _key = 'dark_mode';
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeService() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> toggle() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = !_isDark;
    await prefs.setBool(_key, _isDark);
    notifyListeners();
  }

  ThemeData get theme => ThemeData(
        brightness: _isDark ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: _isDark ? kBackgroundDark : kBackgroundLight,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryGreen, primary: kPrimaryGreen),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: kPrimaryGreen),
        useMaterial3: true,
      );
}
