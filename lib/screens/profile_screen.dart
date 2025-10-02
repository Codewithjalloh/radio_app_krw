import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';
import 'login_screen.dart';
import 'analytics_screen.dart';
import 'help_screen.dart';
import 'contact_screen.dart';
import 'about_screen.dart';
import 'privacy_screen.dart';
import 'terms_screen.dart';

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
                            Text('Profile', style: AppTheme.heading3),
                            Text(
                              'Manage your account & preferences',
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
                        const SizedBox(height: AppTheme.spacingM),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingM,
                            vertical: AppTheme.spacingS,
                          ),
                          decoration: BoxDecoration(
                            color:
                                _isLoggedIn
                                    ? AppTheme.secondaryColor.withOpacity(0.1)
                                    : AppTheme.borderLight,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusRound,
                            ),
                          ),
                          child: Text(
                            _isLoggedIn ? 'Premium Member' : 'Guest User',
                            style: AppTheme.caption.copyWith(
                              color:
                                  _isLoggedIn
                                      ? AppTheme.secondaryColor
                                      : AppTheme.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
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
                      _buildSection('Account', FontAwesomeIcons.userCog, [
                        _buildSettingItem(
                          'Edit Profile',
                          'Update your personal information',
                          FontAwesomeIcons.userEdit,
                          () => _showComingSoon(),
                        ),
                        _buildSettingItem(
                          'Change Password',
                          'Update your account security',
                          FontAwesomeIcons.lock,
                          () => _showComingSoon(),
                        ),
                        _buildSettingItem(
                          'Account Settings',
                          'Manage your account preferences',
                          FontAwesomeIcons.cog,
                          () => _showComingSoon(),
                        ),
                      ]),

                      const SizedBox(height: AppTheme.spacingL),

                      // App Settings
                      _buildSection(
                        'App Settings',
                        FontAwesomeIcons.mobileAlt,
                        [
                          _buildSwitchItem(
                            'Push Notifications',
                            'Receive updates and alerts',
                            FontAwesomeIcons.bell,
                            _notificationsEnabled,
                            (value) =>
                                setState(() => _notificationsEnabled = value),
                          ),
                          _buildSwitchItem(
                            'Auto Play',
                            'Automatically play radio on app open',
                            FontAwesomeIcons.play,
                            _autoPlayEnabled,
                            (value) => setState(() => _autoPlayEnabled = value),
                          ),
                          _buildSwitchItem(
                            'Data Saving',
                            'Reduce data usage for streaming',
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
                        'Support & Information',
                        FontAwesomeIcons.questionCircle,
                        [
                          _buildSettingItem(
                            'Help Center',
                            'Get help and support',
                            FontAwesomeIcons.lifeRing,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpScreen(),
                              ),
                            ),
                          ),
                          _buildSettingItem(
                            'Contact Us',
                            'Reach out to our team',
                            FontAwesomeIcons.envelope,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ContactScreen(),
                              ),
                            ),
                          ),
                          _buildSettingItem(
                            'About KT Radio',
                            'Learn more about our app',
                            FontAwesomeIcons.infoCircle,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutScreen(),
                              ),
                            ),
                          ),
                          _buildSettingItem(
                            'Privacy Policy',
                            'How we protect your data',
                            FontAwesomeIcons.shieldAlt,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyScreen(),
                              ),
                            ),
                          ),
                          _buildSettingItem(
                            'Terms of Service',
                            'Our terms and conditions',
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

                      // Analytics
                      _buildSection('Analytics', FontAwesomeIcons.chartLine, [
                        _buildSettingItem(
                          'User Analytics',
                          'View detailed user insights',
                          FontAwesomeIcons.chartBar,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AnalyticsScreen(),
                            ),
                          ),
                        ),
                      ]),

                      const SizedBox(height: AppTheme.spacingL),

                      // Logout Button
                      if (_isLoggedIn)
                        CustomButton(
                          text: 'Sign Out',
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
            title: Text('Coming Soon', style: AppTheme.heading4),
            content: Text(
              'This feature will be available in a future update.',
              style: AppTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
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
