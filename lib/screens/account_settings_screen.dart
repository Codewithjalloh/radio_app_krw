import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _marketingEmails = false;
  bool _dataSavingEnabled = false;
  bool _autoPlayEnabled = true;
  bool _locationServicesEnabled = false;
  String _languagePreference = 'English';
  String _themePreference = 'Light';

  final List<String> _languages = ['English', 'Kinyarwanda', 'French'];
  final List<String> _themes = ['Light', 'Dark', 'System'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _emailNotifications = prefs.getBool('emailNotifications') ?? true;
      _pushNotifications = prefs.getBool('pushNotifications') ?? true;
      _marketingEmails = prefs.getBool('marketingEmails') ?? false;
      _dataSavingEnabled = prefs.getBool('dataSavingEnabled') ?? false;
      _autoPlayEnabled = prefs.getBool('autoPlayEnabled') ?? true;
      _locationServicesEnabled =
          prefs.getBool('locationServicesEnabled') ?? false;
      _languagePreference = prefs.getString('languagePreference') ?? 'English';
      _themePreference = prefs.getString('themePreference') ?? 'Light';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setBool('emailNotifications', _emailNotifications);
    await prefs.setBool('pushNotifications', _pushNotifications);
    await prefs.setBool('marketingEmails', _marketingEmails);
    await prefs.setBool('dataSavingEnabled', _dataSavingEnabled);
    await prefs.setBool('autoPlayEnabled', _autoPlayEnabled);
    await prefs.setBool('locationServicesEnabled', _locationServicesEnabled);
    await prefs.setString('languagePreference', _languagePreference);
    await prefs.setString('themePreference', _themePreference);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Settings saved successfully!',
            style: AppTheme.bodyMedium.copyWith(color: Colors.white),
          ),
          backgroundColor: AppTheme.primaryColor,
          behavior: SnackBarBehavior.floating,
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
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: AppTheme.shadowGlow,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.cog,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account Settings', style: AppTheme.heading3),
                          Text(
                            'Manage your account preferences',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        FontAwesomeIcons.xmark,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Settings
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  child: Column(
                    children: [
                      // Notifications Section
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.bell,
                                  color: AppTheme.primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(width: AppTheme.spacingS),
                                Text('Notifications', style: AppTheme.heading4),
                              ],
                            ),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildSwitchItem(
                              'Enable Notifications',
                              'Receive push notifications',
                              FontAwesomeIcons.bell,
                              _notificationsEnabled,
                              (value) =>
                                  setState(() => _notificationsEnabled = value),
                            ),

                            if (_notificationsEnabled) ...[
                              _buildSwitchItem(
                                'Email Notifications',
                                'Get updates via email',
                                FontAwesomeIcons.envelope,
                                _emailNotifications,
                                (value) =>
                                    setState(() => _emailNotifications = value),
                              ),

                              _buildSwitchItem(
                                'Push Notifications',
                                'Receive mobile notifications',
                                FontAwesomeIcons.mobile,
                                _pushNotifications,
                                (value) =>
                                    setState(() => _pushNotifications = value),
                              ),

                              _buildSwitchItem(
                                'Marketing Emails',
                                'Receive promotional content',
                                FontAwesomeIcons.bullhorn,
                                _marketingEmails,
                                (value) =>
                                    setState(() => _marketingEmails = value),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // App Preferences
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.mobileAlt,
                                  color: AppTheme.primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(width: AppTheme.spacingS),
                                Text(
                                  'App Preferences',
                                  style: AppTheme.heading4,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildSwitchItem(
                              'Auto Play',
                              'Automatically play radio on app open',
                              FontAwesomeIcons.play,
                              _autoPlayEnabled,
                              (value) =>
                                  setState(() => _autoPlayEnabled = value),
                            ),

                            _buildSwitchItem(
                              'Data Saving',
                              'Reduce data usage for streaming',
                              FontAwesomeIcons.wifi,
                              _dataSavingEnabled,
                              (value) =>
                                  setState(() => _dataSavingEnabled = value),
                            ),

                            _buildSwitchItem(
                              'Location Services',
                              'Use location for local content',
                              FontAwesomeIcons.locationDot,
                              _locationServicesEnabled,
                              (value) => setState(
                                () => _locationServicesEnabled = value,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Language & Theme
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
                                const SizedBox(width: AppTheme.spacingS),
                                Text(
                                  'Language & Theme',
                                  style: AppTheme.heading4,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildDropdownItem(
                              'Language',
                              FontAwesomeIcons.language,
                              _languagePreference,
                              _languages,
                              (value) =>
                                  setState(() => _languagePreference = value!),
                            ),

                            const SizedBox(height: AppTheme.spacingM),

                            _buildDropdownItem(
                              'Theme',
                              FontAwesomeIcons.palette,
                              _themePreference,
                              _themes,
                              (value) =>
                                  setState(() => _themePreference = value!),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Save Button
                      CustomButton(
                        text: 'Save Settings',
                        onPressed: _saveSettings,
                        icon: FontAwesomeIcons.check,
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

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 18),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTheme.caption.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(
    String title,
    IconData icon,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 18),
        ),
        const SizedBox(width: AppTheme.spacingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppTheme.spacingXS),
              DropdownButton<String>(
                value: value,
                isExpanded: true,
                underline: Container(),
                style: AppTheme.bodyMedium,
                items:
                    options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
