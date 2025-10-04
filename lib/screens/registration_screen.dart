import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../theme/app_theme.dart';
import '../widgets/language_preferences_widget.dart';
import '../services/translation_service.dart';
import 'main_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 4;

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Form data
  String _selectedAgeRange = '';
  String _selectedGender = '';
  String _selectedProvince = '';
  String _selectedDistrict = '';
  String _selectedLocationType = '';
  List<String> _selectedLanguages = [];
  Map<String, String> _languageProficiencies = {};
  List<String> _selectedShowTypes = [];
  List<String> _selectedListeningTimes = [];
  String _selectedDeviceType = '';
  String _selectedInternetConnection = '';
  String _selectedDiscoverySource = '';
  List<String> _selectedInterests = [];
  String _selectedListeningFrequency = '';
  String _selectedOccupation = '';
  String _customOccupation = '';
  String _selectedEducationLevel = '';
  String _selectedMaritalStatus = '';
  String _selectedEarningRange = '';
  bool _newsletterSubscription = true;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _completeRegistration();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _completeRegistration() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppTheme.backgroundElevated,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFe94560),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Creating your account...'.tr,
                    style: AppTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );

    // Simulate processing time
    await Future.delayed(const Duration(seconds: 2));

    // Create user model
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      ageRange: _selectedAgeRange,
      gender: _selectedGender,
      province: _selectedProvince,
      district: _selectedDistrict,
      locationType: _selectedLocationType,
      languagePreferences: _selectedLanguages,
      languageProficiencies: _languageProficiencies,
      favoriteShowTypes: _selectedShowTypes,
      listeningTimes: _selectedListeningTimes,
      deviceType: _selectedDeviceType,
      internetConnection: _selectedInternetConnection,
      discoverySource: _selectedDiscoverySource,
      interests: _selectedInterests,
      listeningFrequency: _selectedListeningFrequency,
      occupation: _selectedOccupation.isNotEmpty ? _selectedOccupation : null,
      customOccupation: _customOccupation.isNotEmpty ? _customOccupation : null,
      educationLevel:
          _selectedEducationLevel.isNotEmpty ? _selectedEducationLevel : null,
      maritalStatus:
          _selectedMaritalStatus.isNotEmpty ? _selectedMaritalStatus : null,
      earningRange:
          _selectedEarningRange.isNotEmpty ? _selectedEarningRange : null,
      newsletterSubscription: _newsletterSubscription,
      registrationDate: DateTime.now(),
      lastLogin: DateTime.now(),
    );

    // Save user data
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('userData', user.toJson().toString());

    if (mounted) {
      Navigator.of(context).pop(); // Close loading dialog
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  // Enhanced Header
                  _buildHeader(),

                  // Progress Indicator
                  _buildProgressIndicator(),

                  // Form content
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentStep = index;
                        });
                      },
                      children: [
                        _buildPersonalInfoStep(),
                        _buildLocationStep(),
                        _buildPreferencesStep(),
                        _buildAdditionalInfoStep(),
                      ],
                    ),
                  ),

                  // Enhanced Navigation buttons
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          // Enhanced Logo
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFe94560), Color(0xFFf27121)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFe94560).withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/kt_logo.png',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    FontAwesomeIcons.userPlus,
                    color: Colors.white,
                    size: 30,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join KT Radio'.tr,
                  style: AppTheme.heading2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Step ${_currentStep + 1} of $_totalSteps',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Step indicator dots
          _buildStepDots(),
        ],
      ),
    );
  }

  Widget _buildStepDots() {
    return Row(
      children: List.generate(_totalSteps, (index) {
        final isActive = index <= _currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(left: 4),
          width: isActive ? 12 : 8,
          height: isActive ? 12 : 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFe94560) : AppTheme.borderLight,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 6,
      decoration: BoxDecoration(
        color: AppTheme.borderLight,
        borderRadius: BorderRadius.circular(3),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        width:
            MediaQuery.of(context).size.width *
                ((_currentStep + 1) / _totalSteps) -
            48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFe94560), Color(0xFFf27121)],
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepTitle('Personal Information'.tr, 'Tell us about yourself'),

          const SizedBox(height: 30),

          // Name fields with improved design
          Row(
            children: [
              Expanded(
                child: _buildEnhancedTextField(
                  controller: _firstNameController,
                  label: 'First Name'.tr,
                  icon: FontAwesomeIcons.user,
                  hint: 'Enter your first name',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildEnhancedTextField(
                  controller: _lastNameController,
                  label: 'Last Name'.tr,
                  icon: FontAwesomeIcons.user,
                  hint: 'Enter your last name',
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Email with validation
          _buildEnhancedTextField(
            controller: _emailController,
            label: 'Email Address'.tr,
            icon: FontAwesomeIcons.envelope,
            keyboardType: TextInputType.emailAddress,
            hint: 'Enter your email address',
          ),

          const SizedBox(height: 24),

          // Phone with country code
          _buildEnhancedTextField(
            controller: _phoneController,
            label: 'Phone Number'.tr,
            icon: FontAwesomeIcons.phone,
            keyboardType: TextInputType.phone,
            hint: '+250 788 123 456',
          ),

          const SizedBox(height: 40),

          // Age Range with better design
          _buildSectionTitle('Age Range'.tr),
          const SizedBox(height: 16),
          _buildEnhancedOptionGrid(
            UserDataConstants.ageRanges,
            _selectedAgeRange,
            (value) {
              setState(() {
                _selectedAgeRange = value;
              });
            },
          ),

          const SizedBox(height: 32),

          // Gender with better design
          _buildSectionTitle('Gender'.tr),
          const SizedBox(height: 16),
          _buildEnhancedOptionGrid(UserDataConstants.genders, _selectedGender, (
            value,
          ) {
            setState(() {
              _selectedGender = value;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildLocationStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepTitle('Location Information'.tr, 'Where are you located?'),

          const SizedBox(height: 30),

          // Province
          _buildSectionTitle('Province'.tr),
          const SizedBox(height: 16),
          _buildEnhancedOptionGrid(
            UserDataConstants.provinces,
            _selectedProvince,
            (value) {
              setState(() {
                _selectedProvince = value;
                _selectedDistrict = '';
              });
            },
          ),

          if (_selectedProvince.isNotEmpty) ...[
            const SizedBox(height: 32),
            _buildSectionTitle('District'.tr),
            const SizedBox(height: 16),
            _buildEnhancedOptionGrid(
              UserDataConstants.districts[_selectedProvince] ?? [],
              _selectedDistrict,
              (value) {
                setState(() {
                  _selectedDistrict = value;
                });
              },
            ),
          ],

          const SizedBox(height: 32),

          // Location Type
          _buildSectionTitle('Location Type'.tr),
          const SizedBox(height: 16),
          _buildEnhancedOptionGrid(
            UserDataConstants.locationTypes,
            _selectedLocationType,
            (value) {
              setState(() {
                _selectedLocationType = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepTitle(
            'Radio Preferences'.tr,
            'Customize your listening experience',
          ),

          const SizedBox(height: 30),

          // Language Preferences
          LanguagePreferencesWidget(
            selectedLanguages: _selectedLanguages,
            languageProficiencies: _languageProficiencies,
            onLanguagesChanged: (languages) {
              setState(() {
                _selectedLanguages = languages;
              });
            },
            onProficienciesChanged: (proficiencies) {
              setState(() {
                _languageProficiencies = proficiencies;
              });
            },
            isRequired: true,
          ),

          const SizedBox(height: 32),

          // Favorite Show Types
          _buildSectionTitle('Favorite Show Types (Select all that apply)'),
          const SizedBox(height: 16),
          _buildEnhancedMultiSelectGrid(
            UserDataConstants.showTypes,
            _selectedShowTypes,
            (value) {
              setState(() {
                if (_selectedShowTypes.contains(value)) {
                  _selectedShowTypes.remove(value);
                } else {
                  _selectedShowTypes.add(value);
                }
              });
            },
          ),

          const SizedBox(height: 32),

          // Listening Times
          _buildSectionTitle(
            'When do you usually listen? (Select all that apply)',
          ),
          const SizedBox(height: 16),
          _buildEnhancedMultiSelectGrid(
            UserDataConstants.listeningTimes,
            _selectedListeningTimes,
            (value) {
              setState(() {
                if (_selectedListeningTimes.contains(value)) {
                  _selectedListeningTimes.remove(value);
                } else {
                  _selectedListeningTimes.add(value);
                }
              });
            },
          ),

          const SizedBox(height: 32),

          // Device Type
          _buildSectionTitle('Primary Device'.tr),
          const SizedBox(height: 16),
          _buildEnhancedOptionGrid(
            UserDataConstants.deviceTypes,
            _selectedDeviceType,
            (value) {
              setState(() {
                _selectedDeviceType = value;
              });
            },
          ),

          const SizedBox(height: 32),

          // Internet Connection
          _buildSectionTitle('Internet Connection'.tr),
          const SizedBox(height: 16),
          _buildEnhancedOptionGrid(
            UserDataConstants.internetConnections,
            _selectedInternetConnection,
            (value) {
              setState(() {
                _selectedInternetConnection = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepTitle(
            'Complete Your Profile'.tr,
            'Help us personalize your experience',
          ),

          const SizedBox(height: 30),

          // Discovery Source
          _buildSectionTitle('How did you hear about KT Radio?'),
          const SizedBox(height: 16),
          _buildEnhancedOptionGrid(
            UserDataConstants.discoverySources,
            _selectedDiscoverySource,
            (value) {
              setState(() {
                _selectedDiscoverySource = value;
              });
            },
          ),

          const SizedBox(height: 32),

          // Interests
          _buildSectionTitle(
            'What interests you most? (Select all that apply)',
          ),
          const SizedBox(height: 16),
          _buildEnhancedMultiSelectGrid(
            UserDataConstants.interests,
            _selectedInterests,
            (value) {
              setState(() {
                if (_selectedInterests.contains(value)) {
                  _selectedInterests.remove(value);
                } else {
                  _selectedInterests.add(value);
                }
              });
            },
          ),

          const SizedBox(height: 32),

          // Listening Frequency
          _buildSectionTitle('How often do you listen to radio?'),
          const SizedBox(height: 16),
          _buildEnhancedOptionGrid(
            UserDataConstants.listeningFrequencies,
            _selectedListeningFrequency,
            (value) {
              setState(() {
                _selectedListeningFrequency = value;
              });
            },
          ),

          const SizedBox(height: 32),

          // Additional Information
          _buildSectionTitle('Additional Information'.tr),
          const SizedBox(height: 20),

          // Occupation
          _buildEnhancedDropdownField(
            'Occupation'.tr,
            UserDataConstants.occupations,
            _selectedOccupation,
            (value) {
              setState(() {
                _selectedOccupation = value ?? '';
                if (value != 'Other') {
                  _customOccupation = '';
                }
              });
            },
          ),

          // Custom Occupation Field
          if (_selectedOccupation == 'Other') ...[
            const SizedBox(height: 20),
            _buildEnhancedTextField(
              controller: TextEditingController(text: _customOccupation),
              label: 'Please Specify Your Occupation'.tr,
              icon: FontAwesomeIcons.briefcase,
              hint: 'Enter your occupation',
              onChanged: (value) {
                setState(() {
                  _customOccupation = value;
                });
              },
            ),
          ],

          const SizedBox(height: 20),

          // Education Level
          _buildEnhancedDropdownField(
            'Education Level'.tr,
            UserDataConstants.educationLevels,
            _selectedEducationLevel,
            (value) {
              setState(() {
                _selectedEducationLevel = value ?? '';
              });
            },
          ),

          const SizedBox(height: 20),

          // Marital Status
          _buildEnhancedDropdownField(
            'Marital Status'.tr,
            UserDataConstants.maritalStatuses,
            _selectedMaritalStatus,
            (value) {
              setState(() {
                _selectedMaritalStatus = value ?? '';
              });
            },
          ),

          const SizedBox(height: 20),

          // Earning Range
          _buildEnhancedDropdownField(
            'Earning Range'.tr,
            UserDataConstants.earningRanges,
            _selectedEarningRange,
            (value) {
              setState(() {
                _selectedEarningRange = value ?? '';
              });
            },
          ),

          const SizedBox(height: 32),

          // Newsletter Subscription with enhanced design
          _buildNewsletterCard(),
        ],
      ),
    );
  }

  Widget _buildStepTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.heading2.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textSecondary,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTheme.bodyLarge.copyWith(
        fontWeight: FontWeight.w600,
        color: AppTheme.textPrimary,
        fontSize: 18,
      ),
    );
  }

  Widget _buildEnhancedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: AppTheme.bodyLarge.copyWith(color: AppTheme.textPrimary),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textSecondary,
          ),
          hintStyle: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textSecondary.withOpacity(0.7),
          ),
          prefixIcon: Icon(icon, color: AppTheme.textSecondary, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildEnhancedOptionGrid(
    List<String> options,
    String selected,
    Function(String) onTap,
  ) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          options.map((option) {
            final isSelected = selected == option;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: () => onTap(option),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient:
                        isSelected
                            ? const LinearGradient(
                              colors: [Color(0xFFe94560), Color(0xFFf27121)],
                            )
                            : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color:
                          isSelected
                              ? Colors.transparent
                              : AppTheme.borderLight,
                      width: 1,
                    ),
                    boxShadow:
                        isSelected
                            ? [
                              BoxShadow(
                                color: const Color(0xFFe94560).withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ]
                            : null,
                  ),
                  child: Text(
                    option,
                    style: AppTheme.bodyLarge.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildEnhancedMultiSelectGrid(
    List<String> options,
    List<String> selected,
    Function(String) onTap,
  ) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          options.map((option) {
            final isSelected = selected.contains(option);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: () => onTap(option),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient:
                        isSelected
                            ? const LinearGradient(
                              colors: [Color(0xFFe94560), Color(0xFFf27121)],
                            )
                            : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color:
                          isSelected
                              ? Colors.transparent
                              : AppTheme.borderLight,
                      width: 1,
                    ),
                    boxShadow:
                        isSelected
                            ? [
                              BoxShadow(
                                color: const Color(0xFFe94560).withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ]
                            : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.check,
                            color: Color(0xFFe94560),
                            size: 12,
                          ),
                        ),
                      if (isSelected) const SizedBox(width: 8),
                      Text(
                        option,
                        style: AppTheme.bodyLarge.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected ? Colors.white : AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildEnhancedDropdownField(
    String label,
    List<String> options,
    String selected,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected.isEmpty ? null : selected,
          hint: Text(
            label,
            style: AppTheme.bodyLarge.copyWith(color: AppTheme.textSecondary),
          ),
          dropdownColor: AppTheme.backgroundElevated,
          style: AppTheme.bodyLarge.copyWith(color: AppTheme.textPrimary),
          items:
              options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildNewsletterCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
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
            ),
            child: const Icon(
              FontAwesomeIcons.envelope,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Newsletter Subscription'.tr,
                  style: AppTheme.bodyLarge.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Receive Updates About New Shows And News'.tr,
                  style: AppTheme.caption.copyWith(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _newsletterSubscription,
            onChanged: (value) {
              setState(() {
                _newsletterSubscription = value;
              });
            },
            activeColor: const Color(0xFFe94560),
            activeTrackColor: const Color(0xFFe94560).withOpacity(0.3),
            inactiveThumbColor: AppTheme.textSecondary,
            inactiveTrackColor: AppTheme.borderLight,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderLight, width: 1),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: _previousStep,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: AppTheme.textPrimary,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Previous'.tr,
                            style: AppTheme.bodyLarge.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFe94560), Color(0xFFf27121)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFe94560).withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: _nextStep,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentStep == _totalSteps - 1
                              ? 'Complete Registration'.tr
                              : 'Next'.tr,
                          style: AppTheme.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          _currentStep == _totalSteps - 1
                              ? FontAwesomeIcons.check
                              : FontAwesomeIcons.arrowRight,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
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
