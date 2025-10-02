import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/user_model.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<UserModel> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // In a real app, you would load this from a database
    // For now, we'll simulate some sample data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _users = _generateSampleData();
      _isLoading = false;
    });
  }

  List<UserModel> _generateSampleData() {
    return [
      UserModel(
        id: '1',
        firstName: 'Jean',
        lastName: 'Mukamana',
        email: 'jean@example.com',
        phoneNumber: '+250788123456',
        ageRange: '26-35',
        gender: 'Female',
        province: 'Kigali',
        district: 'Gasabo',
        locationType: 'Urban',
        languagePreferences: ['Kinyarwanda', 'English'],
        favoriteShowTypes: ['News', 'Music'],
        listeningTimes: ['Morning (8-12 PM)', 'Evening (5-8 PM)'],
        deviceType: 'Mobile Phone',
        internetConnection: 'Mobile Data',
        discoverySource: 'Social Media',
        interests: ['Local News', 'Music'],
        listeningFrequency: 'Daily',
        occupation: 'Government Employee',
        educationLevel: 'University',
        maritalStatus: 'Married',
        newsletterSubscription: true,
        registrationDate: DateTime.now().subtract(const Duration(days: 5)),
        lastLogin: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      UserModel(
        id: '2',
        firstName: 'Paul',
        lastName: 'Nkurunziza',
        email: 'paul@example.com',
        phoneNumber: '+250788234567',
        ageRange: '18-25',
        gender: 'Male',
        province: 'Northern Province',
        district: 'Musanze',
        locationType: 'Rural',
        languagePreferences: ['Kinyarwanda', 'French'],
        favoriteShowTypes: ['Sports', 'Talk Shows'],
        listeningTimes: ['Evening (5-8 PM)', 'Night (8-11 PM)'],
        deviceType: 'Mobile Phone',
        internetConnection: 'WiFi',
        discoverySource: 'Friend/Family',
        interests: ['Sports', 'Entertainment'],
        listeningFrequency: 'Several times a week',
        occupation: 'Student',
        educationLevel: 'Secondary School',
        maritalStatus: 'Single',
        newsletterSubscription: false,
        registrationDate: DateTime.now().subtract(const Duration(days: 3)),
        lastLogin: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      UserModel(
        id: '3',
        firstName: 'Marie',
        lastName: 'Uwimana',
        email: 'marie@example.com',
        phoneNumber: '+250788345678',
        ageRange: '36-45',
        gender: 'Female',
        province: 'Southern Province',
        district: 'Huye',
        locationType: 'Urban',
        languagePreferences: ['Kinyarwanda', 'English', 'French'],
        favoriteShowTypes: ['News', 'Educational'],
        listeningTimes: ['Early Morning (5-8 AM)', 'Afternoon (12-5 PM)'],
        deviceType: 'Desktop Computer',
        internetConnection: 'WiFi',
        discoverySource: 'KT Radio Website',
        interests: ['Local News', 'Education', 'Health'],
        listeningFrequency: 'Daily',
        occupation: 'Teacher',
        educationLevel: 'Post-graduate',
        maritalStatus: 'Married',
        newsletterSubscription: true,
        registrationDate: DateTime.now().subtract(const Duration(days: 7)),
        lastLogin: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child:
              _isLoading
                  ? const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  )
                  : SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
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
                                FontAwesomeIcons.chartLine,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'User Analytics',
                                    style: AppTheme.heading3,
                                  ),
                                  Text(
                                    'Understanding your audience',
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Overview Cards
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                'Total Users',
                                _users.length.toString(),
                                FontAwesomeIcons.users,
                                const Color(0xFFe94560),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildStatCard(
                                'Active Today',
                                '${_users.where((u) => u.lastLogin.isAfter(DateTime.now().subtract(const Duration(days: 1)))).length}',
                                FontAwesomeIcons.userCheck,
                                const Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                'Newsletter Subscribers',
                                '${_users.where((u) => u.newsletterSubscription).length}',
                                FontAwesomeIcons.envelope,
                                const Color(0xFF2196F3),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildStatCard(
                                'Mobile Users',
                                '${_users.where((u) => u.deviceType == 'Mobile Phone').length}',
                                FontAwesomeIcons.mobile,
                                const Color(0xFF9C27B0),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Demographics Section
                        _buildSection(
                          'Demographics',
                          FontAwesomeIcons.chartPie,
                          [
                            _buildChartItem(
                              'Age Distribution',
                              _getAgeDistribution(),
                            ),
                            _buildChartItem(
                              'Gender Distribution',
                              _getGenderDistribution(),
                            ),
                            _buildChartItem(
                              'Province Distribution',
                              _getProvinceDistribution(),
                            ),
                            _buildChartItem(
                              'Location Type',
                              _getLocationTypeDistribution(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Preferences Section
                        _buildSection(
                          'User Preferences',
                          FontAwesomeIcons.heart,
                          [
                            _buildChartItem(
                              'Language Preferences',
                              _getLanguageDistribution(),
                            ),
                            _buildChartItem(
                              'Show Types',
                              _getShowTypeDistribution(),
                            ),
                            _buildChartItem(
                              'Listening Times',
                              _getListeningTimeDistribution(),
                            ),
                            _buildChartItem(
                              'Discovery Sources',
                              _getDiscoverySourceDistribution(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // User List
                        _buildSection(
                          'Recent Users',
                          FontAwesomeIcons.userClock,
                          _users
                              .take(5)
                              .map((user) => _buildUserCard(user))
                              .toList(),
                        ),

                        const SizedBox(
                          height: 100,
                        ), // Space for bottom navigation
                      ],
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: AppTheme.shadowSmall,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(value, style: AppTheme.heading3),
          const SizedBox(height: 5),
          Text(
            title,
            style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: AppTheme.shadowSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: 20),
              const SizedBox(width: 10),
              Text(title, style: AppTheme.heading4),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildChartItem(String title, Map<String, int> data) {
    final total = data.values.fold(0, (sum, count) => sum + count);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          ...data.entries.map((entry) {
            final percentage =
                total > 0 ? (entry.value / total * 100).round() : 0;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.key,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.borderLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: total > 0 ? entry.value / total : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$percentage%',
                    style: AppTheme.caption.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildUserCard(UserModel user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: AppTheme.shadowSmall,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                user.firstName[0].toUpperCase(),
                style: AppTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${user.province} • ${user.ageRange}',
                  style: AppTheme.caption.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color:
                  user.lastLogin.isAfter(
                        DateTime.now().subtract(const Duration(hours: 24)),
                      )
                      ? AppTheme.secondaryColor.withOpacity(0.2)
                      : AppTheme.borderLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              user.lastLogin.isAfter(
                    DateTime.now().subtract(const Duration(hours: 24)),
                  )
                  ? 'Active'
                  : 'Offline',
              style: AppTheme.caption.copyWith(
                color:
                    user.lastLogin.isAfter(
                          DateTime.now().subtract(const Duration(hours: 24)),
                        )
                        ? AppTheme.secondaryColor
                        : AppTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Data analysis methods
  Map<String, int> _getAgeDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.ageRange] = (distribution[user.ageRange] ?? 0) + 1;
    }
    return distribution;
  }

  Map<String, int> _getGenderDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.gender] = (distribution[user.gender] ?? 0) + 1;
    }
    return distribution;
  }

  Map<String, int> _getProvinceDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.province] = (distribution[user.province] ?? 0) + 1;
    }
    return distribution;
  }

  Map<String, int> _getLocationTypeDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.locationType] =
          (distribution[user.locationType] ?? 0) + 1;
    }
    return distribution;
  }

  Map<String, int> _getLanguageDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      for (final language in user.languagePreferences) {
        distribution[language] = (distribution[language] ?? 0) + 1;
      }
    }
    return distribution;
  }

  Map<String, int> _getShowTypeDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      for (final showType in user.favoriteShowTypes) {
        distribution[showType] = (distribution[showType] ?? 0) + 1;
      }
    }
    return distribution;
  }

  Map<String, int> _getListeningTimeDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      for (final time in user.listeningTimes) {
        distribution[time] = (distribution[time] ?? 0) + 1;
      }
    }
    return distribution;
  }

  Map<String, int> _getDiscoverySourceDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.discoverySource] =
          (distribution[user.discoverySource] ?? 0) + 1;
    }
    return distribution;
  }
}
