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
  String _selectedTimeframe = 'Last 30 Days';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Simulate loading
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
        languageProficiencies: {'Kinyarwanda': 'Native', 'English': 'Fluent'},
        favoriteShowTypes: ['News', 'Music'],
        listeningTimes: ['Morning (8-12 PM)', 'Evening (5-8 PM)'],
        deviceType: 'Mobile',
        internetConnection: '4G',
        discoverySource: 'Social Media',
        interests: ['Technology', 'Education'],
        listeningFrequency: 'Daily',
        occupation: 'Teacher',
        educationLevel: 'University',
        maritalStatus: 'Married',
        earningRange: '200,000 - 500,000 RWF',
        newsletterSubscription: true,
        registrationDate: DateTime.now().subtract(const Duration(days: 15)),
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
        province: 'Kigali',
        district: 'Nyarugenge',
        locationType: 'Urban',
        languagePreferences: ['Kinyarwanda', 'French'],
        languageProficiencies: {
          'Kinyarwanda': 'Native',
          'French': 'Intermediate',
        },
        favoriteShowTypes: ['Sports', 'Music'],
        listeningTimes: ['Evening (5-8 PM)', 'Night (8-11 PM)'],
        deviceType: 'Mobile',
        internetConnection: 'WiFi',
        discoverySource: 'Friend Recommendation',
        interests: ['Sports', 'Music'],
        listeningFrequency: 'Several times a week',
        occupation: 'Student',
        educationLevel: 'Secondary',
        maritalStatus: 'Single',
        earningRange: 'Under 50,000 RWF',
        newsletterSubscription: false,
        registrationDate: DateTime.now().subtract(const Duration(days: 8)),
        lastLogin: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      UserModel(
        id: '3',
        firstName: 'Marie',
        lastName: 'Uwimana',
        email: 'marie@example.com',
        phoneNumber: '+250788345678',
        ageRange: '36-50',
        gender: 'Female',
        province: 'Eastern',
        district: 'Rwamagana',
        locationType: 'Rural',
        languagePreferences: ['Kinyarwanda'],
        languageProficiencies: {'Kinyarwanda': 'Native'},
        favoriteShowTypes: ['News', 'Talk Shows'],
        listeningTimes: ['Morning (6-9 AM)', 'Afternoon (12-3 PM)'],
        deviceType: 'Radio',
        internetConnection: '3G',
        discoverySource: 'Radio Advertisement',
        interests: ['Agriculture', 'Health'],
        listeningFrequency: 'Daily',
        occupation: 'Farmer',
        educationLevel: 'Primary',
        maritalStatus: 'Married',
        earningRange: '50,000 - 100,000 RWF',
        newsletterSubscription: true,
        registrationDate: DateTime.now().subtract(const Duration(days: 25)),
        lastLogin: DateTime.now().subtract(const Duration(days: 1)),
      ),
      UserModel(
        id: '4',
        firstName: 'David',
        lastName: 'Hakizimana',
        email: 'david@example.com',
        phoneNumber: '+250788456789',
        ageRange: '26-35',
        gender: 'Male',
        province: 'Kigali',
        district: 'Kicukiro',
        locationType: 'Urban',
        languagePreferences: ['English', 'Kinyarwanda'],
        languageProficiencies: {'English': 'Native', 'Kinyarwanda': 'Fluent'},
        favoriteShowTypes: ['Business', 'News'],
        listeningTimes: ['Morning (7-9 AM)', 'Evening (6-8 PM)'],
        deviceType: 'Desktop',
        internetConnection: 'WiFi',
        discoverySource: 'Website',
        interests: ['Business', 'Technology'],
        listeningFrequency: 'Daily',
        occupation: 'Business Owner',
        educationLevel: 'University',
        maritalStatus: 'Married',
        earningRange: '1,000,000 - 2,000,000 RWF',
        newsletterSubscription: true,
        registrationDate: DateTime.now().subtract(const Duration(days: 12)),
        lastLogin: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      UserModel(
        id: '5',
        firstName: 'Grace',
        lastName: 'Mukamana',
        email: 'grace@example.com',
        phoneNumber: '+250788567890',
        ageRange: '18-25',
        gender: 'Female',
        province: 'Northern',
        district: 'Musanze',
        locationType: 'Urban',
        languagePreferences: ['Kinyarwanda', 'English'],
        languageProficiencies: {
          'Kinyarwanda': 'Native',
          'English': 'Intermediate',
        },
        favoriteShowTypes: ['Music', 'Entertainment'],
        listeningTimes: ['Afternoon (2-5 PM)', 'Evening (7-10 PM)'],
        deviceType: 'Mobile',
        internetConnection: '4G',
        discoverySource: 'Social Media',
        interests: ['Music', 'Entertainment'],
        listeningFrequency: 'Weekly',
        occupation: 'Student',
        educationLevel: 'University',
        maritalStatus: 'Single',
        earningRange: 'Under 50,000 RWF',
        newsletterSubscription: true,
        registrationDate: DateTime.now().subtract(const Duration(days: 5)),
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
                      child: Icon(
                        FontAwesomeIcons.chartLine,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User Analytics', style: AppTheme.heading3),
                          Text(
                            'Insights and user behavior data',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Timeframe Selector
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.borderLight),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedTimeframe,
                        underline: Container(),
                        style: AppTheme.bodySmall,
                        items:
                            [
                              'Last 7 Days',
                              'Last 30 Days',
                              'Last 3 Months',
                              'All Time',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedTimeframe = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Analytics Content
              Expanded(
                child:
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingL,
                          ),
                          child: Column(
                            children: [
                              // Key Metrics
                              _buildKeyMetrics(),
                              const SizedBox(height: AppTheme.spacingL),

                              // Demographics
                              _buildDemographicsSection(),
                              const SizedBox(height: AppTheme.spacingL),

                              // Listening Habits
                              _buildListeningHabitsSection(),
                              const SizedBox(height: AppTheme.spacingL),

                              // Geographic Distribution
                              _buildGeographicSection(),
                              const SizedBox(height: AppTheme.spacingL),

                              // Device & Technology
                              _buildTechnologySection(),
                              const SizedBox(height: AppTheme.spacingL),

                              // Engagement Metrics
                              _buildEngagementSection(),
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

  Widget _buildKeyMetrics() {
    final totalUsers = _users.length;
    final activeUsers =
        _users
            .where(
              (u) => u.lastLogin.isAfter(
                DateTime.now().subtract(const Duration(days: 7)),
              ),
            )
            .length;
    final newUsers =
        _users
            .where(
              (u) => u.registrationDate.isAfter(
                DateTime.now().subtract(const Duration(days: 30)),
              ),
            )
            .length;
    final newsletterSubscribers =
        _users.where((u) => u.newsletterSubscription).length;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Key Metrics', style: AppTheme.heading4),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Total Users',
                  totalUsers.toString(),
                  FontAwesomeIcons.users,
                  AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildMetricCard(
                  'Active Users',
                  activeUsers.toString(),
                  FontAwesomeIcons.userCheck,
                  const Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'New Users',
                  newUsers.toString(),
                  FontAwesomeIcons.userPlus,
                  const Color(0xFF2196F3),
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildMetricCard(
                  'Newsletter Subs',
                  newsletterSubscribers.toString(),
                  FontAwesomeIcons.envelope,
                  const Color(0xFFFF9800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: AppTheme.heading3.copyWith(color: color)),
          Text(
            title,
            style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDemographicsSection() {
    final ageGroups = _getAgeGroupDistribution();
    final genderDistribution = _getGenderDistribution();

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Demographics', style: AppTheme.heading4),
          const SizedBox(height: AppTheme.spacingM),

          // Age Groups
          Text(
            'Age Distribution',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...ageGroups.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),

          const SizedBox(height: AppTheme.spacingM),

          // Gender Distribution
          Text(
            'Gender Distribution',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...genderDistribution.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningHabitsSection() {
    final showTypes = _getShowTypeDistribution();
    final listeningTimes = _getListeningTimeDistribution();
    final frequencies = _getListeningFrequencyDistribution();

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Listening Habits', style: AppTheme.heading4),
          const SizedBox(height: AppTheme.spacingM),

          // Favorite Show Types
          Text(
            'Favorite Show Types',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...showTypes.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),

          const SizedBox(height: AppTheme.spacingM),

          // Listening Times
          Text(
            'Preferred Listening Times',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...listeningTimes.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),

          const SizedBox(height: AppTheme.spacingM),

          // Listening Frequency
          Text(
            'Listening Frequency',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...frequencies.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),
        ],
      ),
    );
  }

  Widget _buildGeographicSection() {
    final provinces = _getProvinceDistribution();
    final locationTypes = _getLocationTypeDistribution();

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Geographic Distribution', style: AppTheme.heading4),
          const SizedBox(height: AppTheme.spacingM),

          // Provinces
          Text(
            'Provinces',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...provinces.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),

          const SizedBox(height: AppTheme.spacingM),

          // Location Types
          Text(
            'Location Types',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...locationTypes.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnologySection() {
    final devices = _getDeviceDistribution();
    final connections = _getConnectionDistribution();

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Technology & Devices', style: AppTheme.heading4),
          const SizedBox(height: AppTheme.spacingM),

          // Device Types
          Text(
            'Device Types',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...devices.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),

          const SizedBox(height: AppTheme.spacingM),

          // Internet Connections
          Text(
            'Internet Connections',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...connections.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementSection() {
    final interests = _getInterestDistribution();
    final discoverySources = _getDiscoverySourceDistribution();

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Engagement & Discovery', style: AppTheme.heading4),
          const SizedBox(height: AppTheme.spacingM),

          // Discovery Sources
          Text(
            'How Users Found Us',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...discoverySources.entries.map(
            (entry) =>
                _buildDistributionBar(entry.key, entry.value, _users.length),
          ),

          const SizedBox(height: AppTheme.spacingM),

          // Top Interests
          Text(
            'Top Interests',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          ...interests.entries
              .take(5)
              .map(
                (entry) => _buildDistributionBar(
                  entry.key,
                  entry.value,
                  _users.length,
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildDistributionBar(String label, int count, int total) {
    final percentage = (count / total * 100).round();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(label, style: AppTheme.bodyMedium)),
              Text(
                '$count ($percentage%)',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppTheme.borderLight,
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: count / total,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFe94560), Color(0xFFf27121)],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Data analysis methods
  Map<String, int> _getAgeGroupDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.ageRange] = (distribution[user.ageRange] ?? 0) + 1;
    }
    return Map.fromEntries(
      distribution.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  Map<String, int> _getGenderDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.gender] = (distribution[user.gender] ?? 0) + 1;
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
    return Map.fromEntries(
      distribution.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  Map<String, int> _getListeningTimeDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      for (final time in user.listeningTimes) {
        distribution[time] = (distribution[time] ?? 0) + 1;
      }
    }
    return Map.fromEntries(
      distribution.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  Map<String, int> _getListeningFrequencyDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.listeningFrequency] =
          (distribution[user.listeningFrequency] ?? 0) + 1;
    }
    return Map.fromEntries(
      distribution.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  Map<String, int> _getProvinceDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.province] = (distribution[user.province] ?? 0) + 1;
    }
    return Map.fromEntries(
      distribution.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  Map<String, int> _getLocationTypeDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.locationType] =
          (distribution[user.locationType] ?? 0) + 1;
    }
    return distribution;
  }

  Map<String, int> _getDeviceDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.deviceType] = (distribution[user.deviceType] ?? 0) + 1;
    }
    return Map.fromEntries(
      distribution.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  Map<String, int> _getConnectionDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.internetConnection] =
          (distribution[user.internetConnection] ?? 0) + 1;
    }
    return Map.fromEntries(
      distribution.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  Map<String, int> _getInterestDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      for (final interest in user.interests) {
        distribution[interest] = (distribution[interest] ?? 0) + 1;
      }
    }
    return Map.fromEntries(
      distribution.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  Map<String, int> _getDiscoverySourceDistribution() {
    final Map<String, int> distribution = {};
    for (final user in _users) {
      distribution[user.discoverySource] =
          (distribution[user.discoverySource] ?? 0) + 1;
    }
    return Map.fromEntries(
      distribution.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }
}
