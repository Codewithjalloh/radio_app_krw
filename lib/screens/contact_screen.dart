import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
                          FontAwesomeIcons.envelope,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact Us', style: AppTheme.heading3),
                            Text(
                              'Get in touch with our team',
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

                // Contact Information
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  child: Column(
                    children: [
                      // Main Contact Card
                      CustomCard(
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.broadcastTower,
                              color: AppTheme.primaryColor,
                              size: 50,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text('KT Radio', style: AppTheme.heading3),
                            const SizedBox(height: AppTheme.spacingS),
                            Text(
                              'Rwanda\'s Premier Radio Station',
                              style: AppTheme.bodyLarge.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingXL),

                            // Contact Methods
                            _buildContactMethod(
                              'Email',
                              'contact@ktradio.rw',
                              FontAwesomeIcons.envelope,
                              () => _launchEmail('contact@ktradio.rw'),
                            ),

                            const SizedBox(height: AppTheme.spacingM),

                            _buildContactMethod(
                              'Phone',
                              '+250 788 123 456',
                              FontAwesomeIcons.phone,
                              () => _launchPhone('+250788123456'),
                            ),

                            const SizedBox(height: AppTheme.spacingM),

                            _buildContactMethod(
                              'Website',
                              'www.ktradio.rw',
                              FontAwesomeIcons.globe,
                              () => _launchWebsite('https://www.ktradio.rw'),
                            ),

                            const SizedBox(height: AppTheme.spacingM),

                            _buildContactMethod(
                              'Address',
                              'Kigali, Rwanda',
                              FontAwesomeIcons.mapMarkerAlt,
                              () => _launchMaps('Kigali, Rwanda'),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Social Media
                      CustomCard(
                        child: Column(
                          children: [
                            Text('Follow Us', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSocialButton(
                                  FontAwesomeIcons.facebook,
                                  'Facebook',
                                  () => _launchWebsite(
                                    'https://facebook.com/ktradio',
                                  ),
                                ),
                                _buildSocialButton(
                                  FontAwesomeIcons.twitter,
                                  'Twitter',
                                  () => _launchWebsite(
                                    'https://twitter.com/ktradio',
                                  ),
                                ),
                                _buildSocialButton(
                                  FontAwesomeIcons.instagram,
                                  'Instagram',
                                  () => _launchWebsite(
                                    'https://instagram.com/ktradio',
                                  ),
                                ),
                                _buildSocialButton(
                                  FontAwesomeIcons.youtube,
                                  'YouTube',
                                  () => _launchWebsite(
                                    'https://youtube.com/ktradio',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Office Hours
                      CustomCard(
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.clock,
                              color: AppTheme.primaryColor,
                              size: 30,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text('Office Hours', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingS),
                            Text(
                              'Monday - Friday: 8:00 AM - 6:00 PM',
                              style: AppTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppTheme.spacingXS),
                            Text(
                              'Saturday: 9:00 AM - 4:00 PM',
                              style: AppTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppTheme.spacingXS),
                            Text(
                              'Sunday: Closed',
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.textSecondary,
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

  Widget _buildContactMethod(
    String title,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: AppTheme.backgroundSurface,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          border: Border.all(color: AppTheme.borderLight),
        ),
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
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    value,
                    style: AppTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              FontAwesomeIcons.externalLinkAlt,
              color: AppTheme.textTertiary,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: AppTheme.backgroundSurface,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          border: Border.all(color: AppTheme.borderLight),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 24),
            const SizedBox(height: AppTheme.spacingS),
            Text(label, style: AppTheme.caption),
          ],
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=KT Radio App Support',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchWebsite(String url) async {
    final Uri websiteUri = Uri.parse(url);
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri);
    }
  }

  Future<void> _launchMaps(String address) async {
    final Uri mapsUri = Uri.parse('https://maps.google.com/?q=$address');
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    }
  }
}
