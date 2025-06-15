import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('locale');
    if (langCode != null) {
      _locale = Locale(langCode);
      notifyListeners();
    }
  }

  Future<void> setLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', languageCode);
    _locale = Locale(languageCode);
    notifyListeners();
  }
}
