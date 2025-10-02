import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ['All', 'Amakuru', 'Sports', 'Ibyahise'];

  final List<Map<String, dynamic>> _newsItems = [
    {
      'title':
          'Tanzania: Abantu 38 baguye mu mpanuka ya bisi zagonganye zirashya',
      'category': 'Amakuru',
      'time': 'June 30, 2025',
      'image': 'https://via.placeholder.com/300x200',
      'isBreaking': true,
      'summary':
          'Abantu 38 bapfuye mu mpanuka ya bisi zagonganye mu gihugu cya Tanzania...',
    },
    {
      'title': 'Nyanza: Ingabo za EAC zirimo kuvura abaturage ku buntu',
      'category': 'Amakuru',
      'time': 'June 30, 2025',
      'image': 'https://via.placeholder.com/300x200',
      'isBreaking': false,
      'summary':
          'Ingabo za East African Community zirimo gufasha abaturage ba Nyanza...',
    },
    {
      'title':
          'Chorale de Kigali yateguje igitaramo cy\'amateka ku munsi mpuzamahanga w\'umuziki',
      'category': 'Amakuru',
      'time': 'June 20, 2025',
      'image': 'https://via.placeholder.com/300x200',
      'isBreaking': false,
      'summary':
          'Chorale de Kigali yateguye igitaramo gikomeye ku munsi mpuzamahanga w\'umuziki...',
    },
    {
      'title': 'Ingabo z\'u Rwanda zungutse abandi basirikare',
      'category': 'Amakuru',
      'time': 'June 19, 2025',
      'image': 'https://via.placeholder.com/300x200',
      'isBreaking': false,
      'summary':
          'Ingabo z\'u Rwanda zungutse abandi basirikare mu gikorwa cy\'amahoro...',
    },
    {
      'title': 'Police HC yerekeje muri Kenya mu irushanwa rya ECAHF',
      'category': 'Sports',
      'time': 'June 18, 2025',
      'image': 'https://via.placeholder.com/300x200',
      'isBreaking': false,
      'summary':
          'Police HC yerekeje muri Kenya mu irushanwa rya East and Central Africa Handball Federation...',
    },
    {
      'title': 'Huye: Umugabo yafashwe acuruza inyama z\'imbwa mu isoko',
      'category': 'Ibyahise',
      'time': 'June 17, 2025',
      'image': 'https://via.placeholder.com/300x200',
      'isBreaking': false,
      'summary':
          'Umugabo yafashwe mu karere ka Huye acuruza inyama z\'imbwa mu isoko...',
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
                        FontAwesomeIcons.newspaper,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('News & Updates', style: AppTheme.heading3),
                          Text(
                            'KT Radio News Center',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundCard,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // Breaking News Banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFe94560), Color(0xFFf27121)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFe94560).withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'BREAKING',
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Tanzania: Abantu 38 baguye mu mpanuka ya bisi zagonganye zirashya',
                        style: AppTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(
                      FontAwesomeIcons.arrowRight,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Category Selector
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedCategory == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? const Color(0xFFe94560)
                                  : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color:
                                isSelected
                                    ? const Color(0xFFe94560)
                                    : AppTheme.borderLight,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _categories[index],
                            style: AppTheme.bodyMedium.copyWith(
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
                  },
                ),
              ),

              const SizedBox(height: 20),

              // News List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _newsItems.length,
                  itemBuilder: (context, index) {
                    final news = _newsItems[index];
                    return _buildNewsItem(news, index);
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

  Widget _buildNewsItem(Map<String, dynamic> news, int index) {
    final bool isBreaking = news['isBreaking'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // News Image
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFe94560).withOpacity(0.3),
                  const Color(0xFFf27121).withOpacity(0.3),
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    FontAwesomeIcons.newspaper,
                    color: AppTheme.textTertiary,
                    size: 60,
                  ),
                ),
                if (isBreaking)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFe94560),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'BREAKING',
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.share,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // News Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and Time
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFe94560).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        news['category'],
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      FontAwesomeIcons.clock,
                      color: Colors.white70,
                      size: 12,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      news['time'],
                      style: AppTheme.caption.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // News Title
                Text(
                  news['title'],
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 8),

                // News Summary
                Text(
                  news['summary'],
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 16),

                // Read More Button
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppTheme.borderLight,
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              // Handle read more
                            },
                            child: Center(
                              child: Text(
                                'Read More',
                                style: AppTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFe94560),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            // Handle play audio
                          },
                          child: const Center(
                            child: Icon(
                              FontAwesomeIcons.play,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
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
