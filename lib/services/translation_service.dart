import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationService {
  static const String _defaultLanguage = 'en';
  static const String _languageKey = 'selected_language';

  static final Map<String, Map<String, String>> _translations = {};
  static String _currentLanguage = _defaultLanguage;

  // Initialize the translation service
  static Future<void> initialize() async {
    await _loadLanguage();
    await _loadTranslations();
  }

  // Load saved language preference
  static Future<void> _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _currentLanguage = prefs.getString(_languageKey) ?? _defaultLanguage;
    } catch (e) {
      _currentLanguage = _defaultLanguage;
    }
  }

  // Load all translation files
  static Future<void> _loadTranslations() async {
    final languages = ['en', 'rw', 'fr'];

    // First, try to load English as the base language
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/translations/en.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _translations['en'] = jsonMap.map(
        (key, value) => MapEntry(key, value.toString()),
      );
    } catch (e) {
      print('Error loading English translations: $e');
      // Create a minimal fallback
      _translations['en'] = _createFallbackTranslations();
    }

    // Then load other languages
    for (final lang in languages) {
      if (lang == 'en') continue; // Already loaded

      try {
        final String jsonString = await rootBundle.loadString(
          'assets/translations/$lang.json',
        );
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        _translations[lang] = jsonMap.map(
          (key, value) => MapEntry(key, value.toString()),
        );
      } catch (e) {
        print('Error loading translations for $lang: $e');
        // Use English as fallback
        _translations[lang] = Map.from(_translations['en'] ?? {});
      }
    }
  }

  // Create fallback translations if files can't be loaded
  static Map<String, String> _createFallbackTranslations() {
    return {
      'app_name': 'KT Radio',
      'welcome': 'Welcome',
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'save': 'Save',
      'cancel': 'Cancel',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'profile': 'Profile',
      'home': 'Home',
      'schedule': 'Schedule',
      'news': 'News',
      'settings': 'Settings',
      'language_settings': 'Language Settings',
      'language_preferences': 'Language Preferences',
      'manage_language_preferences': 'Manage your language preferences',
      'select_languages_proficiency':
          'Select the languages you understand and your proficiency level',
      'current_settings': 'Current Settings',
      'language_settings_saved': 'Language settings saved successfully!',
      'error_loading_settings': 'Error loading language settings',
      'error_saving_settings': 'Error saving language settings',
    };
  }

  // Change the current language
  static Future<void> setLanguage(String languageCode) async {
    if (_translations.containsKey(languageCode)) {
      _currentLanguage = languageCode;

      // Save the language preference
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_languageKey, languageCode);
      } catch (e) {
        print('Error saving language preference: $e');
      }
    }
  }

  // Get the current language
  static String get currentLanguage => _currentLanguage;

  // Get available languages
  static List<Map<String, String>> get availableLanguages => [
    {'code': 'en', 'name': 'English', 'nativeName': 'English', 'flag': '🇬🇧'},
    {
      'code': 'rw',
      'name': 'Kinyarwanda',
      'nativeName': 'Ikinyarwanda',
      'flag': '🇷🇼',
    },
    {'code': 'fr', 'name': 'French', 'nativeName': 'Français', 'flag': '🇫🇷'},
  ];

  // Translate a key
  static String translate(String key) {
    final translation =
        _translations[_currentLanguage]?[key] ??
        _translations[_defaultLanguage]?[key] ??
        key;
    return translation;
  }

  // Translate with parameters (for future use)
  static String translateWithParams(String key, Map<String, String> params) {
    String translation = translate(key);

    params.forEach((paramKey, paramValue) {
      translation = translation.replaceAll('{$paramKey}', paramValue);
    });

    return translation;
  }

  // Check if a translation exists
  static bool hasTranslation(String key) {
    return _translations[_currentLanguage]?.containsKey(key) ?? false;
  }

  // Get all translations for current language
  static Map<String, String> get allTranslations =>
      Map.from(_translations[_currentLanguage] ?? {});

  // Reload translations (useful for hot reload)
  static Future<void> reload() async {
    _translations.clear();
    await _loadTranslations();
  }
}

// Extension to make translation easier to use
extension TranslationExtension on String {
  String get tr => TranslationService.translate(this);
}
