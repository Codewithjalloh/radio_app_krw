import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';
import '../services/translation_service.dart';
import 'login_screen.dart';
import 'analytics_screen.dart';
import 'help_screen.dart';
import 'contact_screen.dart';
import 'about_screen.dart';
import 'privacy_screen.dart';
import 'terms_screen.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'account_settings_screen.dart';
import 'advertise_screen.dart';
import 'partnership_screen.dart';
import 'feedback_screen.dart';
import 'language_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = false;
  String _userEmail = '';
  String _userName = '';
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoPlayEnabled = true;
  bool _dataSavingEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      _userEmail = prefs.getString('userEmail') ?? '';
      _userName = prefs.getString('userName') ?? 'Guest User';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingL),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: AppTheme.shadowGlow,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.user,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Profile'.tr, style: AppTheme.heading3),
                            Text(
                              'Manage Account Preferences'.tr,
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

                // User Info Card
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  child: CustomCard(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppTheme.primaryColor.withOpacity(
                            0.1,
                          ),
                          child: Text(
                            _userName.isNotEmpty
                                ? _userName[0].toUpperCase()
                                : 'G',
                            style: AppTheme.heading2.copyWith(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        Text(_userName, style: AppTheme.heading4),
                        const SizedBox(height: AppTheme.spacingXS),
                        Text(
                          _userEmail.isNotEmpty
                              ? _userEmail
                              : 'guest@ktradio.rw',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingL),

                        // Enhanced Premium Member Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppTheme.spacingL),
                          decoration: BoxDecoration(
                            gradient:
                                _isLoggedIn
                                    ? const LinearGradient(
                                      colors: [
                                        Color(0xFFe94560),
                                        Color(0xFFf27121),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                    : null,
                            color: _isLoggedIn ? null : AppTheme.backgroundCard,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusL,
                            ),
                            border: Border.all(
                              color:
                                  _isLoggedIn
                                      ? Colors.transparent
                                      : AppTheme.borderLight,
                              width: 1,
                            ),
                            boxShadow:
                                _isLoggedIn
                                    ? [
                                      BoxShadow(
                                        color: const Color(
                                          0xFFe94560,
                                        ).withOpacity(0.3),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                    : AppTheme.shadowSmall,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color:
                                      _isLoggedIn
                                          ? Colors.white.withOpacity(0.2)
                                          : AppTheme.primaryColor.withOpacity(
                                            0.1,
                                          ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  _isLoggedIn
                                      ? FontAwesomeIcons.crown
                                      : FontAwesomeIcons.user,
                                  color:
                                      _isLoggedIn
                                          ? Colors.white
                                          : AppTheme.primaryColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spacingM),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isLoggedIn
                                          ? 'Premium Member'.tr
                                          : 'Guest User'.tr,
                                      style: AppTheme.heading4.copyWith(
                                        color:
                                            _isLoggedIn
                                                ? Colors.white
                                                : AppTheme.textPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: AppTheme.spacingXS),
                                    Text(
                                      _isLoggedIn
                                          ? 'Enjoy Exclusive Features'.tr
                                          : 'Signup Unlock Premium'.tr,
                                      style: AppTheme.bodySmall.copyWith(
                                        color:
                                            _isLoggedIn
                                                ? Colors.white.withOpacity(0.9)
                                                : AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_isLoggedIn)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.spacingS,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'PRO',
                                    style: AppTheme.caption.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingL),

                // Settings Sections
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  child: Column(
                    children: [
                      // Account Settings
                      _buildSection('Account'.tr, FontAwesomeIcons.userCog, [
                        _buildSettingItem(
                          'Edit Profile'.tr,
                          'Update Personal Info'.tr,
                          FontAwesomeIcons.userEdit,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          ),
                        ),
                        _buildSettingItem(
                          'Change Password'.tr,
                          'Update Account Security'.tr,
                          FontAwesomeIcons.lock,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const ChangePasswordScreen(),
                            ),
                          ),
                        ),
                        _buildSettingItem(
                          'Account Settings'.tr,
                          'Manage Account Preferences'.tr,
                          FontAwesomeIcons.cog,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const AccountSettingsScreen(),
                            ),
                          ),
                        ),
                      ]),

                      const SizedBox(height: AppTheme.spacingL),

                      // App Settings
                      _buildSection(
                        'App Settings'.tr,
                        FontAwesomeIcons.mobileAlt,
                        [
                          _buildSettingItem(
                            'Language Settings'.tr,
                            'Manage Language Preferences'.tr,
                            FontAwesomeIcons.language,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const LanguageSettingsScreen(),
                              ),
                            ),
                          ),
                          _buildSwitchItem(
                            'Push Notifications'.tr,
                            'Receive Updates Alerts'.tr,
                            FontAwesomeIcons.bell,
                            _notificationsEnabled,
                            (value) =>
                                setState(() => _notificationsEnabled = value),
                          ),
                          _buildSwitchItem(
                            'Auto Play'.tr,
                            'Auto Play Radio Description'.tr,
                            FontAwesomeIcons.play,
                            _autoPlayEnabled,
                            (value) => setState(() => _autoPlayEnabled = value),
                          ),
                          _buildSwitchItem(
                            'Data Saving'.tr,
                            'Reduce Data Usage Description'.tr,
                            FontAwesomeIcons.wifi,
                            _dataSavingEnabled,
                            (value) =>
                                setState(() => _dataSavingEnabled = value),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Support & Info
                      _buildSection(
                        'Support Information'.tr,
                        FontAwesomeIcons.questionCircle,
                        [
                          _buildSettingItem(
                            'Help Center'.tr,
                            'Get Help And Support'.tr,
                            FontAwesomeIcons.lifeRing,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpScreen(),
                              ),
                            ),
                          ),
                          _buildSettingItem(
                            'Contact Us'.tr,
                            'Reach Out To Our Team'.tr,
                            FontAwesomeIcons.envelope,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ContactScreen(),
                              ),
                            ),
                          ),
                          _buildSettingItem(
                            'About KT Radio'.tr,
                            'Learn More About Our App'.tr,
                            FontAwesomeIcons.infoCircle,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutScreen(),
                              ),
                            ),
                          ),
                          _buildSettingItem(
                            'Privacy Policy'.tr,
                            'How We Protect Your Data'.tr,
                            FontAwesomeIcons.shieldAlt,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyScreen(),
                              ),
                            ),
                          ),
                          _buildSettingItem(
                            'Terms Of Service'.tr,
                            'Our Terms And Conditions'.tr,
                            FontAwesomeIcons.fileContract,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TermsScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Business & Advertising
                      _buildSection(
                        'Business Advertising'.tr,
                        FontAwesomeIcons.bullhorn,
                        [
                          _buildSettingItem(
                            'Advertise With Us'.tr,
                            'Promote Your Business On KT Radio'.tr,
                            FontAwesomeIcons.bullhorn,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdvertiseScreen(),
                              ),
                            ),
                          ),
                          _buildSettingItem(
                            'Partnership Opportunities'.tr,
                            'Explore Collaboration Options'.tr,
                            FontAwesomeIcons.handshake,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PartnershipScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Feedback
                      _buildSection('Feedback'.tr, FontAwesomeIcons.commentDots, [
                        _buildSettingItem(
                          'Share Your Feedback'.tr,
                          'Help us improve KT Radio with your thoughts and suggestions'
                              .tr,
                          FontAwesomeIcons.commentDots,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FeedbackScreen(),
                            ),
                          ),
                        ),
                      ]),

                      const SizedBox(height: AppTheme.spacingL),

                      // Analytics
                      _buildSection(
                        'User Analytics Admin Section Only'.tr,
                        FontAwesomeIcons.chartLine,
                        [
                          _buildSettingItem(
                            'User Analytics Admin Section Only'.tr,
                            'View Detailed User Insights'.tr,
                            FontAwesomeIcons.chartBar,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AnalyticsScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Logout Button
                      if (_isLoggedIn)
                        CustomButton(
                          text: 'Sign Out'.tr,
                          onPressed: _logout,
                          isOutlined: true,
                          icon: FontAwesomeIcons.signOutAlt,
                        ),

                      const SizedBox(height: AppTheme.spacingXXL),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: 20),
              const SizedBox(width: AppTheme.spacingS),
              Text(title, style: AppTheme.heading4),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusS),
        ),
        child: Icon(icon, color: AppTheme.primaryColor, size: 18),
      ),
      title: Text(
        title,
        style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
      ),
      trailing: const Icon(
        FontAwesomeIcons.chevronRight,
        color: AppTheme.textTertiary,
        size: 14,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusS),
        ),
        child: Icon(icon, color: AppTheme.primaryColor, size: 18),
      ),
      title: Text(
        title,
        style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }

  void _showComingSoon() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Coming Soon'.tr, style: AppTheme.heading4),
            content: Text(
              'This Feature Will Be Available In A Future Update'.tr,
              style: AppTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK'.tr,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
