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

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 4;

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
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeRegistration();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeRegistration() async {
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          'assets/images/kt_logo.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to icon if image not found
                            return const Icon(
                              FontAwesomeIcons.userPlus,
                              color: Colors.white,
                              size: 24,
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
                          Text('Join KT Radio'.tr, style: AppTheme.heading3),
                          Text(
                            'Step ${_currentStep + 1} of $_totalSteps',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Progress indicator
                    Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.borderLight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (_currentStep + 1) / _totalSteps,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFe94560),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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

              // Navigation buttons
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.backgroundCard,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppTheme.borderLight,
                              width: 1,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: _previousStep,
                              child: Center(
                                child: Text(
                                  'Previous',
                                  style: AppTheme.bodyLarge.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        height: 50,
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
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: _nextStep,
                            child: Center(
                              child: Text(
                                _currentStep == _totalSteps - 1
                                    ? 'Complete'
                                    : 'Next',
                                style: AppTheme.bodyLarge.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Personal Information'.tr, style: AppTheme.heading4),
            const SizedBox(height: 20),

            // Name fields
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _firstNameController,
                    label: 'First Name',
                    icon: FontAwesomeIcons.user,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildTextField(
                    controller: _lastNameController,
                    label: 'Last Name',
                    icon: FontAwesomeIcons.user,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Email
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              icon: FontAwesomeIcons.envelope,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 20),

            // Phone
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: FontAwesomeIcons.phone,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 30),

            // Age Range
            Text(
              'Age Range',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildOptionGrid(UserDataConstants.ageRanges, _selectedAgeRange, (
              value,
            ) {
              setState(() {
                _selectedAgeRange = value;
              });
            }),

            const SizedBox(height: 30),

            // Gender
            Text(
              'Gender',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildOptionGrid(UserDataConstants.genders, _selectedGender, (
              value,
            ) {
              setState(() {
                _selectedGender = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location Information'.tr, style: AppTheme.heading4),
            const SizedBox(height: 20),

            // Province
            Text(
              'Province',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildOptionGrid(UserDataConstants.provinces, _selectedProvince, (
              value,
            ) {
              setState(() {
                _selectedProvince = value;
                _selectedDistrict = ''; // Reset district when province changes
              });
            }),

            if (_selectedProvince.isNotEmpty) ...[
              const SizedBox(height: 30),
              Text(
                'District',
                style: AppTheme.bodyLarge.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 15),
              _buildOptionGrid(
                UserDataConstants.districts[_selectedProvince] ?? [],
                _selectedDistrict,
                (value) {
                  setState(() {
                    _selectedDistrict = value;
                  });
                },
              ),
            ],

            const SizedBox(height: 30),

            // Location Type
            Text(
              'Location Type',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildOptionGrid(
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
      ),
    );
  }

  Widget _buildPreferencesStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Radio Preferences'.tr, style: AppTheme.heading4),
            const SizedBox(height: 20),

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

            const SizedBox(height: 30),

            // Favorite Show Types
            Text(
              'Favorite Show Types (Select all that apply)',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildMultiSelectGrid(
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

            const SizedBox(height: 30),

            // Listening Times
            Text(
              'When do you usually listen? (Select all that apply)',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildMultiSelectGrid(
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

            const SizedBox(height: 30),

            // Device Type
            Text(
              'Primary Device',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildOptionGrid(
              UserDataConstants.deviceTypes,
              _selectedDeviceType,
              (value) {
                setState(() {
                  _selectedDeviceType = value;
                });
              },
            ),

            const SizedBox(height: 30),

            // Internet Connection
            Text(
              'Internet Connection',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildOptionGrid(
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
      ),
    );
  }

  Widget _buildAdditionalInfoStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Complete Your Profile'.tr, style: AppTheme.heading4),
            const SizedBox(height: 20),

            // Discovery Source
            Text(
              'How did you hear about KT Radio?',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildOptionGrid(
              UserDataConstants.discoverySources,
              _selectedDiscoverySource,
              (value) {
                setState(() {
                  _selectedDiscoverySource = value;
                });
              },
            ),

            const SizedBox(height: 30),

            // Interests
            Text(
              'What interests you most? (Select all that apply)',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildMultiSelectGrid(
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

            const SizedBox(height: 30),

            // Listening Frequency
            Text(
              'How often do you listen to radio?',
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            _buildOptionGrid(
              UserDataConstants.listeningFrequencies,
              _selectedListeningFrequency,
              (value) {
                setState(() {
                  _selectedListeningFrequency = value;
                });
              },
            ),

            const SizedBox(height: 30),

            // Additional fields
            Text(
              'Additional Information',
              style: AppTheme.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 15),

            // Occupation
            _buildDropdownField(
              'Occupation',
              UserDataConstants.occupations,
              _selectedOccupation,
              (value) {
                setState(() {
                  _selectedOccupation = value ?? '';
                  if (value != 'Other') {
                    _customOccupation =
                        ''; // Clear custom occupation if not "Other"
                  }
                });
              },
            ),

            // Custom Occupation Field (only show if "Other" is selected)
            if (_selectedOccupation == 'Other') ...[
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.backgroundCard,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppTheme.borderLight, width: 1),
                ),
                child: TextFormField(
                  initialValue: _customOccupation,
                  onChanged: (value) {
                    setState(() {
                      _customOccupation = value;
                    });
                  },
                  style: AppTheme.bodyLarge,
                  decoration: InputDecoration(
                    labelText: 'Please specify your occupation',
                    labelStyle: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.briefcase,
                      color: AppTheme.textSecondary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Education Level
            _buildDropdownField(
              'Education Level',
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
            _buildDropdownField(
              'Marital Status',
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
            _buildDropdownField(
              'Earning Range',
              UserDataConstants.earningRanges,
              _selectedEarningRange,
              (value) {
                setState(() {
                  _selectedEarningRange = value ?? '';
                });
              },
            ),

            const SizedBox(height: 30),

            // Newsletter Subscription
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.backgroundCard,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppTheme.borderLight, width: 1),
              ),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.envelope,
                    color: const Color(0xFFe94560),
                    size: 20,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Newsletter Subscription',
                          style: AppTheme.bodyLarge.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'Receive updates about new shows and news',
                          style: AppTheme.caption.copyWith(
                            color: AppTheme.textSecondary,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: AppTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textSecondary,
          ),
          prefixIcon: Icon(icon, color: AppTheme.textSecondary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildOptionGrid(
    List<String> options,
    String selected,
    Function(String) onTap,
  ) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children:
          options.map((option) {
            final isSelected = selected == option;
            return GestureDetector(
              onTap: () => onTap(option),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
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
                            : Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  option,
                  style: AppTheme.bodyLarge.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildMultiSelectGrid(
    List<String> options,
    List<String> selected,
    Function(String) onTap,
  ) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children:
          options.map((option) {
            final isSelected = selected.contains(option);
            return GestureDetector(
              onTap: () => onTap(option),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
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
                            : Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected)
                      Icon(
                        FontAwesomeIcons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    if (isSelected) const SizedBox(width: 8),
                    Text(
                      option,
                      style: AppTheme.bodyLarge.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            isSelected ? Colors.white : AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> options,
    String selected,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected.isEmpty ? null : selected,
          hint: Text(
            label,
            style: AppTheme.bodyLarge.copyWith(color: AppTheme.textSecondary),
          ),
          dropdownColor: AppTheme.backgroundElevated,
          style: AppTheme.bodyLarge,
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
}
