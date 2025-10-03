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
  bool _isLoading = true;
  bool _isSaving = false;
  String _appLanguage = 'rw';

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
      setState(() {
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
      setState(() {
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Language Settings Saved'.tr),
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
            content: Text('Error Saving Settings'.tr + ': $e'),
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
                              // Language Selection Card
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
                                          'Select Language'.tr,
                                          style: AppTheme.heading4,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppTheme.spacingM),
                                    Text(
                                      'Choose your preferred language for the entire app'
                                          .tr,
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

                              // Current Language Display
                              CustomCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.checkCircle,
                                          color: AppTheme.primaryColor,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: AppTheme.spacingS,
                                        ),
                                        Text(
                                          'Current Language'.tr,
                                          style: AppTheme.heading4,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppTheme.spacingM),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(
                                        AppTheme.spacingM,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          AppTheme.radiusS,
                                        ),
                                        border: Border.all(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            TranslationService
                                                .availableLanguages
                                                .firstWhere(
                                                  (lang) =>
                                                      lang['code'] ==
                                                      _appLanguage,
                                                )['flag']!,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: AppTheme.spacingS,
                                          ),
                                          Text(
                                            TranslationService
                                                .availableLanguages
                                                .firstWhere(
                                                  (lang) =>
                                                      lang['code'] ==
                                                      _appLanguage,
                                                )['nativeName']!,
                                            style: AppTheme.bodyLarge.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
