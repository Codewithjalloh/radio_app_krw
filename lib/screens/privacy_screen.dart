import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

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
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: AppTheme.shadowGlow,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.shieldAlt,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Privacy Policy', style: AppTheme.heading3),
                            Text(
                              'How we protect your data',
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
                          FontAwesomeIcons.times,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Privacy Policy Content
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  child: Column(
                    children: [
                      // Last Updated
                      CustomCard(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.calendarAlt,
                              color: AppTheme.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: AppTheme.spacingM),
                            Text(
                              'Last Updated: December 2024',
                              style: AppTheme.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Introduction
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Introduction', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'At KT Radio, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our mobile application.',
                              style: AppTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Information We Collect
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Information We Collect',
                              style: AppTheme.heading4,
                            ),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildPrivacySection(
                              'Personal Information',
                              'We collect information you provide directly to us, such as when you create an account, including your name, email address, and phone number.',
                            ),

                            _buildPrivacySection(
                              'Usage Data',
                              'We automatically collect information about how you use our app, including your listening habits, favorite shows, and device information.',
                            ),

                            _buildPrivacySection(
                              'Location Data',
                              'With your permission, we may collect your general location to provide localized content and improve our services.',
                            ),

                            _buildPrivacySection(
                              'Device Information',
                              'We collect information about your device, including device type, operating system, and unique device identifiers.',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // How We Use Your Information
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How We Use Your Information',
                              style: AppTheme.heading4,
                            ),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildUsageItem(
                              FontAwesomeIcons.broadcastTower,
                              'Provide Services',
                              'Deliver radio streaming and app functionality',
                            ),

                            _buildUsageItem(
                              FontAwesomeIcons.userCog,
                              'Personalize Experience',
                              'Customize content and recommendations',
                            ),

                            _buildUsageItem(
                              FontAwesomeIcons.chartLine,
                              'Analytics',
                              'Improve our services and user experience',
                            ),

                            _buildUsageItem(
                              FontAwesomeIcons.envelope,
                              'Communications',
                              'Send updates and notifications',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Data Security
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Data Security', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'We implement industry-standard security measures to protect your personal information, including:',
                              style: AppTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildSecurityItem(
                              'Encryption of data in transit and at rest',
                            ),
                            _buildSecurityItem(
                              'Regular security audits and updates',
                            ),
                            _buildSecurityItem(
                              'Limited access to personal information',
                            ),
                            _buildSecurityItem(
                              'Secure data storage and processing',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Your Rights
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Rights', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'You have the right to:',
                              style: AppTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildRightItem('Access your personal data'),
                            _buildRightItem('Correct inaccurate information'),
                            _buildRightItem('Delete your account and data'),
                            _buildRightItem('Opt-out of communications'),
                            _buildRightItem('Data portability'),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Contact Information
                      CustomCard(
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.envelope,
                              color: AppTheme.primaryColor,
                              size: 30,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'Questions About Privacy?',
                              style: AppTheme.heading4,
                            ),
                            const SizedBox(height: AppTheme.spacingS),
                            Text(
                              'If you have any questions about this Privacy Policy or our data practices, please contact us:',
                              style: AppTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'Email: privacy@ktradio.rw',
                              style: AppTheme.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingXL),
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

  Widget _buildPrivacySection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            content,
            style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageItem(IconData icon, String title, String description) {
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
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  description,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.check,
            color: AppTheme.secondaryColor,
            size: 14,
          ),
          const SizedBox(width: AppTheme.spacingS),
          Expanded(child: Text(text, style: AppTheme.bodyMedium)),
        ],
      ),
    );
  }

  Widget _buildRightItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.userCheck,
            color: AppTheme.primaryColor,
            size: 14,
          ),
          const SizedBox(width: AppTheme.spacingS),
          Expanded(child: Text(text, style: AppTheme.bodyMedium)),
        ],
      ),
    );
  }
}
