import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/language_preferences_widget.dart';
import '../widgets/custom_widgets.dart';
import '../services/translation_service.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  List<String> _selectedLanguages = [];
  Map<String, String> _languageProficiencies = {};
  bool _isLoading = true;
  bool _isSaving = false;
  String _appLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _loadLanguageSettings();
  }

  Future<void> _loadLanguageSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      // Load saved language preferences
      final savedLanguages =
          prefs.getStringList('userLanguagePreferences') ?? [];
      final savedProficiencies = <String, String>{};

      // Load saved proficiencies
      for (final language in savedLanguages) {
        final proficiency = prefs.getString('languageProficiency_$language');
        if (proficiency != null) {
          savedProficiencies[language] = proficiency;
        }
      }

      setState(() {
        _selectedLanguages = savedLanguages;
        _languageProficiencies = savedProficiencies;
        _appLanguage = TranslationService.currentLanguage;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading language settings: $e'),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
      }
    }
  }

  Future<void> _saveLanguageSettings() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      // Save language preferences
      await prefs.setStringList('userLanguagePreferences', _selectedLanguages);

      // Save proficiencies
      for (final entry in _languageProficiencies.entries) {
        await prefs.setString('languageProficiency_${entry.key}', entry.value);
      }

      setState(() {
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('language_settings_saved'.tr),
            backgroundColor: const Color(0xFF4CAF50),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('error_saving_settings'.tr + ': $e'),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
      }
    }
  }

  Future<void> _changeAppLanguage(String languageCode) async {
    await TranslationService.setLanguage(languageCode);
    setState(() {
      _appLanguage = languageCode;
    });

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'App language changed to ${TranslationService.availableLanguages.firstWhere((lang) => lang['code'] == languageCode)['name']}',
          ),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.borderLight),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: AppTheme.primaryColor,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Language Settings'.tr,
                            style: AppTheme.heading3,
                          ),
                          Text(
                            'Manage Language Preferences'.tr,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Save Button
                    if (!_isLoading)
                      GestureDetector(
                        onTap: _isSaving ? null : _saveLanguageSettings,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingM,
                            vertical: AppTheme.spacingS,
                          ),
                          decoration: BoxDecoration(
                            color:
                                _isSaving
                                    ? AppTheme.textTertiary
                                    : AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_isSaving) ...[
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ] else ...[
                                const Icon(
                                  FontAwesomeIcons.save,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                _isSaving ? 'loading'.tr : 'save'.tr,
                                style: AppTheme.bodySmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child:
                    _isLoading
                        ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.primaryColor,
                            ),
                          ),
                        )
                        : SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingL,
                          ),
                          child: Column(
                            children: [
                              // App Language Selection Card
                              CustomCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.globe,
                                          color: AppTheme.primaryColor,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: AppTheme.spacingS,
                                        ),
                                        Text(
                                          'App Language',
                                          style: AppTheme.heading4,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppTheme.spacingM),
                                    Text(
                                      'Choose the language for the app interface',
                                      style: AppTheme.bodyMedium.copyWith(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: AppTheme.spacingL),

                                    // Language Selection Buttons
                                    Wrap(
                                      spacing: AppTheme.spacingS,
                                      runSpacing: AppTheme.spacingS,
                                      children:
                                          TranslationService.availableLanguages.map((
                                            lang,
                                          ) {
                                            final isSelected =
                                                _appLanguage == lang['code'];
                                            return GestureDetector(
                                              onTap:
                                                  () => _changeAppLanguage(
                                                    lang['code']!,
                                                  ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal:
                                                          AppTheme.spacingM,
                                                      vertical:
                                                          AppTheme.spacingS,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      isSelected
                                                          ? AppTheme
                                                              .primaryColor
                                                          : AppTheme
                                                              .backgroundElevated,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        AppTheme.radiusL,
                                                      ),
                                                  border: Border.all(
                                                    color:
                                                        isSelected
                                                            ? AppTheme
                                                                .primaryColor
                                                            : AppTheme
                                                                .borderLight,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      lang['flag']!,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      lang['nativeName']!,
                                                      style: AppTheme.bodyMedium
                                                          .copyWith(
                                                            color:
                                                                isSelected
                                                                    ? Colors
                                                                        .white
                                                                    : AppTheme
                                                                        .textPrimary,
                                                            fontWeight:
                                                                isSelected
                                                                    ? FontWeight
                                                                        .w600
                                                                    : FontWeight
                                                                        .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: AppTheme.spacingL),

                              // Language Preferences Card
                              CustomCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.language,
                                          color: AppTheme.primaryColor,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: AppTheme.spacingS,
                                        ),
                                        Text(
                                          'Language Preferences'.tr,
                                          style: AppTheme.heading4,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppTheme.spacingM),
                                    Text(
                                      'Select Languages Proficiency'.tr,
                                      style: AppTheme.bodyMedium.copyWith(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: AppTheme.spacingL),

                                    // Language Preferences Widget
                                    LanguagePreferencesWidget(
                                      selectedLanguages: _selectedLanguages,
                                      languageProficiencies:
                                          _languageProficiencies,
                                      onLanguagesChanged: (languages) {
                                        setState(() {
                                          _selectedLanguages = languages;
                                        });
                                      },
                                      onProficienciesChanged: (proficiencies) {
                                        setState(() {
                                          _languageProficiencies =
                                              proficiencies;
                                        });
                                      },
                                      isRequired: false,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: AppTheme.spacingL),

                              // Current Settings Summary
                              if (_selectedLanguages.isNotEmpty)
                                CustomCard(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.infoCircle,
                                            color: AppTheme.primaryColor,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: AppTheme.spacingS,
                                          ),
                                          Text(
                                            'Current Settings'.tr,
                                            style: AppTheme.heading4,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: AppTheme.spacingM),

                                      ..._selectedLanguages.map((language) {
                                        final proficiency =
                                            _languageProficiencies[language] ??
                                            'Not specified';
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            bottom: AppTheme.spacingS,
                                          ),
                                          padding: const EdgeInsets.all(
                                            AppTheme.spacingM,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppTheme.backgroundElevated,
                                            borderRadius: BorderRadius.circular(
                                              AppTheme.radiusS,
                                            ),
                                            border: Border.all(
                                              color: AppTheme.borderLight,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                language,
                                                style: AppTheme.bodyMedium
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                              const SizedBox(
                                                width: AppTheme.spacingS,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal:
                                                          AppTheme.spacingS,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: AppTheme.primaryColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  proficiency,
                                                  style: AppTheme.caption
                                                      .copyWith(
                                                        color:
                                                            AppTheme
                                                                .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),

                              const SizedBox(height: AppTheme.spacingXXL),
                            ],
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
