import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../services/translation_service.dart';
import 'language_settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _isPlaying = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  List<String> _userLanguages = [];
  bool _languagesLoaded = false;

  // Radio Player Controls
  double _volume = 0.7;
  String _audioQuality = 'High';
  bool _isMuted = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _loadUserLanguages();
  }

  Future<void> _loadUserLanguages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languages = prefs.getStringList('userLanguagePreferences') ?? [];
      setState(() {
        _userLanguages = languages;
        _languagesLoaded = true;
      });
    } catch (e) {
      setState(() {
        _languagesLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _changeVolume(double value) {
    setState(() {
      _volume = value;
      if (_volume > 0) {
        _isMuted = false;
      }
    });
  }

  void _changeAudioQuality(String quality) {
    setState(() {
      _audioQuality = quality;
    });
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
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFe94560), Color(0xFFf27121)],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFe94560).withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/kt_logo.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to text logo if image not found
                              return const Center(
                                child: Text(
                                  'KT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('App Name'.tr, style: AppTheme.heading3),
                            Text(
                              'Radio Tagline'.tr,
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            if (_languagesLoaded &&
                                _userLanguages.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.language,
                                    size: 12,
                                    color: AppTheme.textTertiary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _userLanguages.take(2).join(', ') +
                                        (_userLanguages.length > 2
                                            ? '...'
                                            : ''),
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFe94560),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'live'.tr,
                                  style: AppTheme.caption.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const LanguageSettingsScreen(),
                                ),
                              );
                              // Reload languages when returning from settings
                              _loadUserLanguages();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.backgroundCard,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppTheme.borderLight),
                              ),
                              child: Icon(
                                FontAwesomeIcons.language,
                                color: AppTheme.primaryColor,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Current Show Info
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.borderLight, width: 1),
                    boxShadow: AppTheme.shadowSmall,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Now Playing'.tr,
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Ubyumva Ute?', style: AppTheme.heading3),
                      const SizedBox(height: 5),
                      Text(
                        'Cyateguwe na Anne Marie Niwemwiza',
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFe94560).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xFFe94560).withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '7:30 PM - 8:30 PM',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Radio Player
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _isPlaying ? _pulseAnimation.value : 1.0,
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFe94560).withOpacity(0.3),
                              const Color(0xFFe94560).withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFFe94560), Color(0xFFf27121)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFe94560,
                                  ).withOpacity(0.4),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: _togglePlayPause,
                                child: Center(
                                  child: Icon(
                                    _isPlaying
                                        ? FontAwesomeIcons.pause
                                        : FontAwesomeIcons.play,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Enhanced Radio Player Controls
                _buildRadioPlayerControls(),

                const SizedBox(height: 40),

                // Quick Access to Shows
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Popular Shows'.tr, style: AppTheme.heading4),
                      const SizedBox(height: 20),
                      _buildShowCard(
                        'Impamba y\'umunsi',
                        'Cyateguwe na Ben Nganji',
                        '8:30 PM - 11:00 PM',
                        FontAwesomeIcons.moon,
                      ),
                      const SizedBox(height: 15),
                      _buildShowCard(
                        'Burakeye',
                        'Cyateguwe na Jean Claude Rusakara',
                        '5:00 AM - 8:00 AM',
                        FontAwesomeIcons.sun,
                      ),
                      const SizedBox(height: 15),
                      _buildShowCard(
                        'KT Sports',
                        'Cyateguwe n\'Itsinda ry\'Abanyamakuru',
                        '8:05 AM - 9:00 AM',
                        FontAwesomeIcons.futbol,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100), // Space for bottom navigation
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioPlayerControls() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: AppTheme.shadowMedium,
      ),
      child: Column(
        children: [
          // Volume Control
          Row(
            children: [
              Icon(
                _isMuted
                    ? FontAwesomeIcons.volumeXmark
                    : FontAwesomeIcons.volumeHigh,
                color: _isMuted ? AppTheme.errorColor : AppTheme.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppTheme.primaryColor,
                    inactiveTrackColor: AppTheme.borderLight,
                    thumbColor: AppTheme.primaryColor,
                    overlayColor: AppTheme.primaryColor.withOpacity(0.2),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: _isMuted ? 0.0 : _volume,
                    onChanged: _changeVolume,
                    min: 0.0,
                    max: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _toggleMute,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:
                        _isMuted
                            ? AppTheme.errorColor.withOpacity(0.1)
                            : AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _isMuted
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh,
                    color:
                        _isMuted ? AppTheme.errorColor : AppTheme.primaryColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Audio Quality and Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Audio Quality Selector
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.music,
                      color: AppTheme.primaryColor,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _audioQuality,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    PopupMenuButton<String>(
                      icon: Icon(
                        FontAwesomeIcons.chevronDown,
                        color: AppTheme.primaryColor,
                        size: 12,
                      ),
                      onSelected: _changeAudioQuality,
                      itemBuilder:
                          (context) => [
                            const PopupMenuItem(
                              value: 'Low',
                              child: Text('Low (64kbps)'),
                            ),
                            const PopupMenuItem(
                              value: 'Medium',
                              child: Text('Medium (128kbps)'),
                            ),
                            const PopupMenuItem(
                              value: 'High',
                              child: Text('High (320kbps)'),
                            ),
                          ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                children: [
                  _buildActionButton(
                    icon:
                        _isFavorite
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                    isActive: _isFavorite,
                    onTap: _toggleFavorite,
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    icon: FontAwesomeIcons.share,
                    onTap: () {
                      // Share functionality
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    icon: FontAwesomeIcons.list,
                    onTap: () {
                      // Playlist functionality
                    },
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Status Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Connection Status
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          _isPlaying
                              ? AppTheme.secondaryColor
                              : AppTheme.textTertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _isPlaying ? 'Connected'.tr : 'Disconnected'.tr,
                    style: AppTheme.bodySmall.copyWith(
                      color:
                          _isPlaying
                              ? AppTheme.secondaryColor
                              : AppTheme.textTertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Audio Quality Info
              Text(
                '${_audioQuality} Quality'.tr,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryColor : AppTheme.backgroundElevated,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? AppTheme.primaryColor : AppTheme.borderLight,
            width: 1,
          ),
          boxShadow: AppTheme.shadowSmall,
        ),
        child: Center(
          child: Icon(
            icon,
            color: isActive ? Colors.white : AppTheme.textSecondary,
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildShowCard(String title, String host, String time, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: AppTheme.shadowSmall,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFe94560).withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: const Color(0xFFe94560), size: 24),
          ),
          const SizedBox(width: 15),
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
                const SizedBox(height: 4),
                Text(
                  host,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: AppTheme.caption.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(FontAwesomeIcons.play, color: AppTheme.textSecondary, size: 16),
        ],
      ),
    );
  }
}
