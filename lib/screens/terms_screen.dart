import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

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
                          FontAwesomeIcons.fileContract,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Terms of Service', style: AppTheme.heading3),
                            Text(
                              'Our terms and conditions',
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

                // Terms Content
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

                      // Acceptance of Terms
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1. Acceptance of Terms',
                              style: AppTheme.heading4,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'By downloading, installing, or using the KT Radio mobile application, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our app.',
                              style: AppTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'We reserve the right to modify these terms at any time. Continued use of the app after changes constitutes acceptance of the new terms.',
                              style: AppTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Use of Service
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('2. Use of Service', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildTermSection(
                              'Permitted Use',
                              'The app is provided for personal, non-commercial use only. You may use the app to listen to radio content, access show schedules, and read news updates.',
                            ),

                            _buildTermSection('Prohibited Activities', 'You may not:', [
                              'Reverse engineer, decompile, or disassemble the app',
                              'Use the app for any illegal or unauthorized purpose',
                              'Interfere with or disrupt the app\'s functionality',
                              'Attempt to gain unauthorized access to our systems',
                              'Redistribute, modify, or create derivative works',
                            ]),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Content and Intellectual Property
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3. Content and Intellectual Property',
                              style: AppTheme.heading4,
                            ),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildTermSection(
                              'Ownership',
                              'All content, including music, news, shows, and app features, is owned by KT Radio and protected by copyright laws.',
                            ),

                            _buildTermSection(
                              'License',
                              'We grant you a limited, non-exclusive, non-transferable license to use the app for personal purposes only.',
                            ),

                            _buildTermSection(
                              'User Content',
                              'Any content you submit to us becomes our property and may be used for promotional or operational purposes.',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Privacy and Data
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '4. Privacy and Data',
                              style: AppTheme.heading4,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'Your privacy is important to us. Our collection and use of personal information is governed by our Privacy Policy, which is incorporated into these terms by reference.',
                              style: AppTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'By using the app, you consent to the collection and use of your information as described in our Privacy Policy.',
                              style: AppTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Disclaimers
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('5. Disclaimers', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildDisclaimerItem(
                              FontAwesomeIcons.exclamationTriangle,
                              'Service Availability',
                              'We do not guarantee uninterrupted service availability.',
                            ),

                            _buildDisclaimerItem(
                              FontAwesomeIcons.wifi,
                              'Internet Connection',
                              'A stable internet connection is required for app functionality.',
                            ),

                            _buildDisclaimerItem(
                              FontAwesomeIcons.shieldAlt,
                              'Content Accuracy',
                              'We strive for accuracy but cannot guarantee all content is error-free.',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Limitation of Liability
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '6. Limitation of Liability',
                              style: AppTheme.heading4,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'To the maximum extent permitted by law, KT Radio shall not be liable for any indirect, incidental, special, or consequential damages arising from your use of the app.',
                              style: AppTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'Our total liability shall not exceed the amount you paid for the app, if any.',
                              style: AppTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Termination
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('7. Termination', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'We may terminate or suspend your access to the app at any time, with or without notice, for any reason, including violation of these terms.',
                              style: AppTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'You may stop using the app at any time by uninstalling it from your device.',
                              style: AppTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Governing Law
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('8. Governing Law', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'These terms are governed by the laws of Rwanda. Any disputes shall be resolved in the courts of Rwanda.',
                              style: AppTheme.bodyMedium,
                            ),
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
                              'Questions About Terms?',
                              style: AppTheme.heading4,
                            ),
                            const SizedBox(height: AppTheme.spacingS),
                            Text(
                              'If you have any questions about these Terms of Service, please contact us:',
                              style: AppTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'Email: legal@ktradio.rw',
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

  Widget _buildTermSection(
    String title,
    String content, [
    List<String>? items,
  ]) {
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
          if (items != null) ...[
            const SizedBox(height: AppTheme.spacingS),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(
                  left: AppTheme.spacingM,
                  bottom: AppTheme.spacingXS,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDisclaimerItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
            ),
            child: Icon(icon, color: AppTheme.warningColor, size: 18),
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
}
