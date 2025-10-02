import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
                          FontAwesomeIcons.lifeRing,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Help Center', style: AppTheme.heading3),
                            Text(
                              'Get help and support',
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

                // FAQ Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Frequently Asked Questions',
                        style: AppTheme.heading4,
                      ),
                      const SizedBox(height: AppTheme.spacingM),

                      _buildFAQItem(
                        'How do I listen to KT Radio?',
                        'Simply tap the play button on the home screen to start listening to live radio. You can also browse shows in the schedule section.',
                      ),

                      _buildFAQItem(
                        'Can I listen offline?',
                        'KT Radio is a live streaming service, so an internet connection is required. However, you can save your favorite shows for later reference.',
                      ),

                      _buildFAQItem(
                        'How do I change my account settings?',
                        'Go to the Profile tab and tap on "Account Settings" to update your personal information, password, and preferences.',
                      ),

                      _buildFAQItem(
                        'Why is the audio not playing?',
                        'Check your internet connection and ensure your device volume is turned up. You can also try closing and reopening the app.',
                      ),

                      _buildFAQItem(
                        'How do I contact KT Radio?',
                        'You can reach us through the Contact Us section in your profile, or email us directly at contact@ktradio.rw.',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXL),

                // Contact Support
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  child: CustomCard(
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.headset,
                          color: AppTheme.primaryColor,
                          size: 40,
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        Text('Still need help?', style: AppTheme.heading4),
                        const SizedBox(height: AppTheme.spacingS),
                        Text(
                          'Our support team is here to help you with any questions or issues you may have.',
                          style: AppTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppTheme.spacingL),
                        CustomButton(
                          text: 'Contact Support',
                          onPressed: () {
                            // Navigate to contact screen
                          },
                          icon: FontAwesomeIcons.envelope,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: AppTheme.spacingM),
        title: Text(
          question,
          style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        children: [
          Text(
            answer,
            style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}
