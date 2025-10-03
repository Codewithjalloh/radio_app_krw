import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

class LanguagePreferencesWidget extends StatefulWidget {
  final List<String> selectedLanguages;
  final Map<String, String> languageProficiencies;
  final Function(List<String>) onLanguagesChanged;
  final Function(Map<String, String>) onProficienciesChanged;
  final bool isRequired;

  const LanguagePreferencesWidget({
    super.key,
    required this.selectedLanguages,
    required this.languageProficiencies,
    required this.onLanguagesChanged,
    required this.onProficienciesChanged,
    this.isRequired = true,
  });

  @override
  State<LanguagePreferencesWidget> createState() =>
      _LanguagePreferencesWidgetState();
}

class _LanguagePreferencesWidgetState extends State<LanguagePreferencesWidget> {
  static const Map<String, Map<String, String>> _languages = {
    'Kinyarwanda': {'nativeName': 'Ikinyarwanda', 'flag': '🇷🇼', 'code': 'rw'},
    'English': {'nativeName': 'English', 'flag': '🇬🇧', 'code': 'en'},
    'French': {'nativeName': 'Français', 'flag': '🇫🇷', 'code': 'fr'},
  };

  static const List<String> _proficiencyLevels = [
    'Beginner',
    'Intermediate',
    'Fluent',
    'Native',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Text(
              'Language Preferences',
              style: AppTheme.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            if (widget.isRequired) ...[
              const SizedBox(width: 4),
              Text(
                '*',
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Select the languages you understand and your proficiency level',
          style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
        ),
        const SizedBox(height: AppTheme.spacingM),

        // Language Cards
        ..._languages.entries.map((entry) {
          final language = entry.key;
          final details = entry.value;
          final isSelected = widget.selectedLanguages.contains(language);
          final proficiency = widget.languageProficiencies[language] ?? '';

          return Container(
            margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
            child: _buildLanguageCard(
              language: language,
              details: details,
              isSelected: isSelected,
              proficiency: proficiency,
            ),
          );
        }),

        // Validation Message
        if (widget.isRequired && widget.selectedLanguages.isEmpty)
          Container(
            margin: const EdgeInsets.only(top: AppTheme.spacingS),
            padding: const EdgeInsets.all(AppTheme.spacingS),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
              border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.exclamationCircle,
                  color: AppTheme.primaryColor,
                  size: 16,
                ),
                const SizedBox(width: AppTheme.spacingS),
                Expanded(
                  child: Text(
                    'Please select at least one language',
                    style: AppTheme.caption.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLanguageCard({
    required String language,
    required Map<String, String> details,
    required bool isSelected,
    required String proficiency,
  }) {
    return GestureDetector(
      onTap: () => _toggleLanguageSelection(language),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppTheme.primaryColor.withOpacity(0.1)
                  : AppTheme.backgroundCard,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.borderLight,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? AppTheme.shadowSmall : null,
        ),
        child: Column(
          children: [
            // Language Header
            Row(
              children: [
                // Flag
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? AppTheme.primaryColor.withOpacity(0.2)
                            : AppTheme.borderLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      details['flag']!,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),

                // Language Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language,
                        style: AppTheme.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected
                                  ? AppTheme.primaryColor
                                  : AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        details['nativeName']!,
                        style: AppTheme.bodySmall.copyWith(
                          color:
                              isSelected
                                  ? AppTheme.primaryColor.withOpacity(0.8)
                                  : AppTheme.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                // Selection Indicator
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppTheme.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isSelected
                              ? AppTheme.primaryColor
                              : AppTheme.borderLight,
                      width: 2,
                    ),
                  ),
                  child:
                      isSelected
                          ? const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 12,
                          )
                          : null,
                ),
              ],
            ),

            // Proficiency Level (only show if language is selected)
            if (isSelected) ...[
              const SizedBox(height: AppTheme.spacingM),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingS,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Proficiency Level',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Wrap(
                      spacing: AppTheme.spacingS,
                      runSpacing: AppTheme.spacingS,
                      children:
                          _proficiencyLevels.map((level) {
                            final isSelectedLevel = proficiency == level;
                            return GestureDetector(
                              onTap: () => _selectProficiency(language, level),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.spacingM,
                                  vertical: AppTheme.spacingS,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelectedLevel
                                          ? AppTheme.primaryColor
                                          : AppTheme.backgroundElevated,
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusL,
                                  ),
                                  border: Border.all(
                                    color:
                                        isSelectedLevel
                                            ? AppTheme.primaryColor
                                            : AppTheme.borderLight,
                                  ),
                                ),
                                child: Text(
                                  level,
                                  style: AppTheme.caption.copyWith(
                                    color:
                                        isSelectedLevel
                                            ? Colors.white
                                            : AppTheme.textSecondary,
                                    fontWeight:
                                        isSelectedLevel
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _toggleLanguageSelection(String language) {
    setState(() {
      if (widget.selectedLanguages.contains(language)) {
        // Remove language
        widget.selectedLanguages.remove(language);
        widget.languageProficiencies.remove(language);
      } else {
        // Add language
        widget.selectedLanguages.add(language);
        // Set default proficiency to 'Intermediate' for new selections
        widget.languageProficiencies[language] = 'Intermediate';
      }
    });

    widget.onLanguagesChanged(List.from(widget.selectedLanguages));
    widget.onProficienciesChanged(Map.from(widget.languageProficiencies));
  }

  void _selectProficiency(String language, String proficiency) {
    setState(() {
      widget.languageProficiencies[language] = proficiency;
    });

    widget.onProficienciesChanged(Map.from(widget.languageProficiencies));
  }
}
