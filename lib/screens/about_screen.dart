import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                          FontAwesomeIcons.infoCircle,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About KT Radio', style: AppTheme.heading3),
                            Text(
                              'Learn more about our app',
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

                // App Information
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  child: Column(
                    children: [
                      // App Logo and Version
                      CustomCard(
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: AppTheme.primaryGradient,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: AppTheme.shadowGlow,
                              ),
                              child: const Icon(
                                FontAwesomeIcons.radio,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text('KT Radio', style: AppTheme.heading2),
                            const SizedBox(height: AppTheme.spacingS),
                            Text(
                              'Version 1.0.0',
                              style: AppTheme.bodyLarge.copyWith(
                                color: AppTheme.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'Rwanda\'s Premier Radio Station',
                              style: AppTheme.bodyLarge.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // App Description
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About Our App', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'KT Radio is Rwanda\'s premier radio station, bringing you real talk and great music 24/7. Our mobile app provides seamless access to live streaming, show schedules, news updates, and more.',
                              style: AppTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'With our user-friendly interface and comprehensive features, you can stay connected to your favorite shows, discover new content, and never miss important news updates.',
                              style: AppTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Features
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('App Features', style: AppTheme.heading4),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildFeatureItem(
                              FontAwesomeIcons.play,
                              'Live Streaming',
                              'Listen to KT Radio live 24/7',
                            ),

                            _buildFeatureItem(
                              FontAwesomeIcons.calendar,
                              'Show Schedule',
                              'View upcoming shows and programs',
                            ),

                            _buildFeatureItem(
                              FontAwesomeIcons.newspaper,
                              'News Updates',
                              'Stay informed with latest news',
                            ),

                            _buildFeatureItem(
                              FontAwesomeIcons.chartBar,
                              'User Analytics',
                              'Track your listening habits',
                            ),

                            _buildFeatureItem(
                              FontAwesomeIcons.user,
                              'Personal Profile',
                              'Customize your experience',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Technical Information
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Technical Information',
                              style: AppTheme.heading4,
                            ),
                            const SizedBox(height: AppTheme.spacingM),

                            _buildTechInfo('Platform', 'Flutter'),
                            _buildTechInfo(
                              'Minimum OS',
                              'Android 5.0 / iOS 12.0',
                            ),
                            _buildTechInfo(
                              'Internet Required',
                              'Yes (for live streaming)',
                            ),
                            _buildTechInfo('Data Usage', '~1MB per minute'),
                            _buildTechInfo('Last Updated', 'December 2024'),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      // Copyright
                      CustomCard(
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.copyright,
                              color: AppTheme.textSecondary,
                              size: 20,
                            ),
                            const SizedBox(height: AppTheme.spacingS),
                            Text(
                              '© 2024 KT Radio',
                              style: AppTheme.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingXS),
                            Text(
                              'All rights reserved',
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              'Made with ❤️ in Rwanda',
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500,
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

  Widget _buildFeatureItem(IconData icon, String title, String description) {
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

  Widget _buildTechInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
          ),
          Text(
            value,
            style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
