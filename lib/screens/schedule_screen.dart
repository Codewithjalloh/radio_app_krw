import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../services/translation_service.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDay = 0;
  final List<String> _days = ['Today'.tr, 'Tomorrow'.tr, 'This Week'.tr];

  final List<Map<String, dynamic>> _todaySchedule = [
    {
      'time': '5:00 AM - 8:00 AM',
      'title': 'Burakeye',
      'host': 'Jean Claude Rusakara',
      'description': 'Morning show with news and music',
      'icon': FontAwesomeIcons.sun,
      'isLive': false,
    },
    {
      'time': '8:00 AM - 8:05 AM',
      'title': 'News Headlines',
      'host': 'Itsinda ry\'Abanyamakuru',
      'description': 'Latest news updates',
      'icon': FontAwesomeIcons.newspaper,
      'isLive': false,
    },
    {
      'time': '8:05 AM - 9:00 AM',
      'title': 'KT Sports',
      'host': 'Itsinda ry\'Abanyamakuru',
      'description': 'Sports news and updates',
      'icon': FontAwesomeIcons.futbol,
      'isLive': false,
    },
    {
      'time': '7:30 PM - 8:30 PM',
      'title': 'Ubyumva Ute?',
      'host': 'Anne Marie Niwemwiza',
      'description': 'Evening talk show',
      'icon': FontAwesomeIcons.microphone,
      'isLive': true,
    },
    {
      'time': '8:30 PM - 11:00 PM',
      'title': 'Impamba y\'umunsi',
      'host': 'Ben Nganji',
      'description': 'Night show with music and entertainment',
      'icon': FontAwesomeIcons.moon,
      'isLive': false,
    },
  ];

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
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFe94560),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFe94560).withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        FontAwesomeIcons.calendar,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Show Schedule', style: AppTheme.heading3),
                          Text(
                            'KT Radio 96.7 FM',
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

              // Day Selector
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundCard,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppTheme.borderLight, width: 1),
                ),
                child: Row(
                  children:
                      _days.asMap().entries.map((entry) {
                        int index = entry.key;
                        String day = entry.value;
                        bool isSelected = _selectedDay == index;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDay = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? const Color(0xFFe94560)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                day,
                                textAlign: TextAlign.center,
                                style: AppTheme.bodyMedium.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // Schedule List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _todaySchedule.length,
                  itemBuilder: (context, index) {
                    final show = _todaySchedule[index];
                    return _buildScheduleItem(show, index);
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> show, int index) {
    final bool isLive = show['isLive'] as bool;
    final bool isPast = index < 2; // First two shows are past

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            isLive
                ? const Color(0xFFe94560).withOpacity(0.1)
                : AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isLive
                  ? const Color(0xFFe94560).withOpacity(0.3)
                  : AppTheme.borderLight,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Time and Status
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  show['time'],
                  style: AppTheme.bodyMedium.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color:
                        isLive
                            ? const Color(0xFFe94560)
                            : isPast
                            ? AppTheme.textSecondary
                            : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                if (isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFe94560),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'LIVE',
                          style: AppTheme.bodyMedium.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (isPast)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.borderLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'ENDED',
                      style: AppTheme.bodyMedium.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'UPCOMING',
                      style: AppTheme.bodyMedium.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          // Show Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  isLive
                      ? const Color(0xFFe94560).withOpacity(0.2)
                      : AppTheme.borderLight,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              show['icon'],
              color: isLive ? const Color(0xFFe94560) : AppTheme.textSecondary,
              size: 24,
            ),
          ),

          const SizedBox(width: 15),

          // Show Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  show['title'],
                  style: AppTheme.bodyMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  show['host'],
                  style: AppTheme.bodyMedium.copyWith(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  show['description'],
                  style: AppTheme.bodyMedium.copyWith(
                    fontSize: 12,
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
          ),

          // Action Button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isLive ? const Color(0xFFe94560) : AppTheme.borderLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  // Handle show action
                },
                child: Center(
                  child: Icon(
                    isLive ? FontAwesomeIcons.play : FontAwesomeIcons.clock,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
