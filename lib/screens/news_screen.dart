import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../services/translation_service.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = [
    'All'.tr,
    'Amakuru',
    'Sports'.tr,
    'Ibyahise',
  ];

  final List<Map<String, dynamic>> _newsItems = [
    {
      'title':
          'Tanzania: Abantu 38 baguye mu mpanuka ya bisi zagonganye zirashya',
      'category': 'Amakuru',
      'time': 'June 30, 2025',
      'image': 'https://picsum.photos/400/250?random=1',
      'isBreaking': true,
      'summary':
          'Abantu 38 bapfuye mu mpanuka ya bisi zagonganye mu gihugu cya Tanzania...',
    },
    {
      'title': 'Nyanza: Ingabo za EAC zirimo kuvura abaturage ku buntu',
      'category': 'Amakuru',
      'time': 'June 30, 2025',
      'image': 'https://picsum.photos/400/250?random=2',
      'isBreaking': false,
      'summary':
          'Ingabo za East African Community zirimo gufasha abaturage ba Nyanza...',
    },
    {
      'title':
          'Chorale de Kigali yateguje igitaramo cy\'amateka ku munsi mpuzamahanga w\'umuziki',
      'category': 'Amakuru',
      'time': 'June 20, 2025',
      'image': 'https://picsum.photos/400/250?random=3',
      'isBreaking': false,
      'summary':
          'Chorale de Kigali yateguye igitaramo gikomeye ku munsi mpuzamahanga w\'umuziki...',
    },
    {
      'title': 'Ingabo z\'u Rwanda zungutse abandi basirikare',
      'category': 'Amakuru',
      'time': 'June 19, 2025',
      'image': 'https://picsum.photos/400/250?random=4',
      'isBreaking': false,
      'summary':
          'Ingabo z\'u Rwanda zungutse abandi basirikare mu gikorwa cyo gufasha...',
    },
    {
      'title': 'Rwanda: Umukino wa basketball w\'abagore w\'u Rwanda watsinze',
      'category': 'Sports',
      'time': 'June 18, 2025',
      'image': 'https://picsum.photos/400/250?random=5',
      'isBreaking': false,
      'summary':
          'Umukino wa basketball w\'abagore w\'u Rwanda watsinze mu gikorwa cya...',
    },
    {
      'title': 'Kigali: Umudugudu wa Kimisagara wavuguruye',
      'category': 'Amakuru',
      'time': 'June 17, 2025',
      'image': 'https://picsum.photos/400/250?random=6',
      'isBreaking': false,
      'summary':
          'Umudugudu wa Kimisagara wavuguruye mu gikorwa cyo gufasha abaturage...',
    },
    {
      'title': 'Umuziki w\'u Rwanda: Abahanzi bavuga ku ngaruka z\'ubucuruzi',
      'category': 'Ibyahise',
      'time': 'June 16, 2025',
      'image': 'https://picsum.photos/400/250?random=7',
      'isBreaking': false,
      'summary':
          'Abahanzi b\'u Rwanda bavuga ku ngaruka z\'ubucuruzi ku muziki w\'u Rwanda...',
    },
    {
      'title': 'Amashuri y\'u Rwanda: Ubwoba bw\'abanyeshuri',
      'category': 'Amakuru',
      'time': 'June 15, 2025',
      'image': 'https://picsum.photos/400/250?random=8',
      'isBreaking': false,
      'summary':
          'Amashuri y\'u Rwanda yagaragaje ubwoba bw\'abanyeshuri mu gikorwa cya...',
    },
  ];

  List<Map<String, dynamic>> get _filteredNews {
    if (_selectedCategory == 0) return _newsItems;
    final category = _categories[_selectedCategory];
    return _newsItems.where((item) => item['category'] == category).toList();
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
                      child: const Icon(
                        FontAwesomeIcons.newspaper,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('News'.tr, style: AppTheme.heading3),
                          Text(
                            'Stay Informed With Latest News'.tr,
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

              // Breaking News Banner
              if (_newsItems.any((item) => item['isBreaking'] == true))
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFe94560), Color(0xFFf27121)],
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    boxShadow: AppTheme.shadowSmall,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.exclamationTriangle,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacingS),
                      Expanded(
                        child: Text(
                          'Breaking News'.tr,
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: AppTheme.spacingL),

              // Category Tabs
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingL,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategory == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: AppTheme.spacingS),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingM,
                          vertical: AppTheme.spacingS,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppTheme.primaryColor
                                  : AppTheme.backgroundCard,
                          borderRadius: BorderRadius.circular(AppTheme.radiusL),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppTheme.primaryColor
                                    : AppTheme.borderLight,
                          ),
                          boxShadow: isSelected ? AppTheme.shadowSmall : null,
                        ),
                        child: Center(
                          child: Text(
                            _categories[index],
                            style: AppTheme.bodyMedium.copyWith(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : AppTheme.textPrimary,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppTheme.spacingL),

              // News List
              Expanded(
                child:
                    _filteredNews.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.newspaper,
                                color: AppTheme.textSecondary,
                                size: 48,
                              ),
                              const SizedBox(height: AppTheme.spacingM),
                              Text(
                                'No News Available'.tr,
                                style: AppTheme.bodyLarge.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingL,
                          ),
                          itemCount: _filteredNews.length,
                          itemBuilder: (context, index) {
                            final news = _filteredNews[index];
                            return _buildNewsCard(news);
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> news) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(color: AppTheme.borderLight),
        boxShadow: AppTheme.shadowSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusM),
              topRight: Radius.circular(AppTheme.radiusM),
            ),
            child: Stack(
              children: [
                Image.network(
                  news['image'],
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 220,
                      color: AppTheme.backgroundElevated,
                      child: Center(
                        child: CircularProgressIndicator(
                          value:
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor.withOpacity(0.1),
                            AppTheme.primaryColor.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.image,
                            color: AppTheme.primaryColor.withOpacity(0.6),
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Image Not Available'.tr,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                if (news['isBreaking'] == true)
                  Positioned(
                    top: AppTheme.spacingS,
                    left: AppTheme.spacingS,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingS,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFe94560),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Breaking'.tr,
                        style: AppTheme.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: AppTheme.spacingS,
                  right: AppTheme.spacingS,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingS,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      news['category'],
                      style: AppTheme.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news['title'],
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.spacingS),
                Text(
                  news['summary'],
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.spacingM),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.clock,
                      size: 12,
                      color: AppTheme.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      news['time'],
                      style: AppTheme.caption.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
