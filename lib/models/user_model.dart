class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String ageRange;
  final String gender;
  final String province;
  final String district;
  final String locationType; // Urban/Rural
  final List<String> languagePreferences;
  final Map<String, String> languageProficiencies;
  final List<String> favoriteShowTypes;
  final List<String> listeningTimes;
  final String deviceType;
  final String internetConnection;
  final String discoverySource;
  final List<String> interests;
  final String listeningFrequency;
  final String? occupation;
  final String? customOccupation;
  final String? educationLevel;
  final String? maritalStatus;
  final String? earningRange;
  final bool newsletterSubscription;
  final DateTime registrationDate;
  final DateTime lastLogin;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.ageRange,
    required this.gender,
    required this.province,
    required this.district,
    required this.locationType,
    required this.languagePreferences,
    required this.languageProficiencies,
    required this.favoriteShowTypes,
    required this.listeningTimes,
    required this.deviceType,
    required this.internetConnection,
    required this.discoverySource,
    required this.interests,
    required this.listeningFrequency,
    this.occupation,
    this.customOccupation,
    this.educationLevel,
    this.maritalStatus,
    this.earningRange,
    required this.newsletterSubscription,
    required this.registrationDate,
    required this.lastLogin,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'ageRange': ageRange,
      'gender': gender,
      'province': province,
      'district': district,
      'locationType': locationType,
      'languagePreferences': languagePreferences,
      'languageProficiencies': languageProficiencies,
      'favoriteShowTypes': favoriteShowTypes,
      'listeningTimes': listeningTimes,
      'deviceType': deviceType,
      'internetConnection': internetConnection,
      'discoverySource': discoverySource,
      'interests': interests,
      'listeningFrequency': listeningFrequency,
      'occupation': occupation,
      'customOccupation': customOccupation,
      'educationLevel': educationLevel,
      'maritalStatus': maritalStatus,
      'earningRange': earningRange,
      'newsletterSubscription': newsletterSubscription,
      'registrationDate': registrationDate.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      ageRange: json['ageRange'],
      gender: json['gender'],
      province: json['province'],
      district: json['district'],
      locationType: json['locationType'],
      languagePreferences: List<String>.from(json['languagePreferences']),
      languageProficiencies: Map<String, String>.from(
        json['languageProficiencies'] ?? {},
      ),
      favoriteShowTypes: List<String>.from(json['favoriteShowTypes']),
      listeningTimes: List<String>.from(json['listeningTimes']),
      deviceType: json['deviceType'],
      internetConnection: json['internetConnection'],
      discoverySource: json['discoverySource'],
      interests: List<String>.from(json['interests']),
      listeningFrequency: json['listeningFrequency'],
      occupation: json['occupation'],
      customOccupation: json['customOccupation'],
      educationLevel: json['educationLevel'],
      maritalStatus: json['maritalStatus'],
      earningRange: json['earningRange'],
      newsletterSubscription: json['newsletterSubscription'],
      registrationDate: DateTime.parse(json['registrationDate']),
      lastLogin: DateTime.parse(json['lastLogin']),
    );
  }
}

// Constants for form options
class UserDataConstants {
  static const List<String> ageRanges = [
    '18-25',
    '26-35',
    '36-45',
    '46-55',
    '55+',
  ];

  static const List<String> genders = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  static const List<String> provinces = [
    'Kigali',
    'Northern Province',
    'Southern Province',
    'Eastern Province',
    'Western Province',
  ];

  static const Map<String, List<String>> districts = {
    'Kigali': ['Nyarugenge', 'Gasabo', 'Kicukiro'],
    'Northern Province': ['Burera', 'Gakenke', 'Gicumbi', 'Musanze', 'Rulindo'],
    'Southern Province': [
      'Gisagara',
      'Huye',
      'Kamonyi',
      'Muhanga',
      'Nyamagabe',
      'Nyanza',
      'Nyaruguru',
      'Ruhango',
    ],
    'Eastern Province': [
      'Bugesera',
      'Gatsibo',
      'Kayonza',
      'Kirehe',
      'Ngoma',
      'Nyagatare',
      'Rwamagana',
    ],
    'Western Province': [
      'Karongi',
      'Ngororero',
      'Nyabihu',
      'Nyamasheke',
      'Rubavu',
      'Rusizi',
      'Rutsiro',
    ],
  };

  static const List<String> locationTypes = ['Urban', 'Rural'];

  static const List<String> languages = [
    'Kinyarwanda',
    'English',
    'French',
    'Swahili',
  ];

  static const List<String> showTypes = [
    'News',
    'Music',
    'Talk Shows',
    'Sports',
    'Entertainment',
    'Educational',
    'Religious',
  ];

  static const List<String> listeningTimes = [
    'Early Morning (5-8 AM)',
    'Morning (8-12 PM)',
    'Afternoon (12-5 PM)',
    'Evening (5-8 PM)',
    'Night (8-11 PM)',
    'Late Night (11 PM-5 AM)',
  ];

  static const List<String> deviceTypes = [
    'Mobile Phone',
    'Desktop Computer',
    'Tablet',
    'Smart TV',
  ];

  static const List<String> internetConnections = [
    'WiFi',
    'Mobile Data',
    'Both',
  ];

  static const List<String> discoverySources = [
    'Social Media',
    'Friend/Family',
    'KT Radio Website',
    'Search Engine',
    'Advertisement',
    'Other Radio Station',
    'Other',
  ];

  static const List<String> interests = [
    'Local News',
    'International News',
    'Music',
    'Sports',
    'Talk Shows',
    'Entertainment',
    'Education',
    'Business',
    'Technology',
    'Health',
  ];

  static const List<String> listeningFrequencies = [
    'Daily',
    'Several times a week',
    'Weekly',
    'Occasionally',
  ];

  static const List<String> occupations = [
    'Student',
    'Government Employee',
    'Private Sector Employee',
    'Business Owner',
    'Farmer',
    'Teacher',
    'Healthcare Worker',
    'Unemployed',
    'Retired',
    'Other',
  ];

  static const List<String> educationLevels = [
    'Primary School',
    'Secondary School',
    'University',
    'Post-graduate',
    'Technical/Vocational',
  ];

  static const List<String> maritalStatuses = [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];

  static const List<String> earningRanges = [
    'Under 50,000 RWF',
    '50,000 - 100,000 RWF',
    '100,000 - 200,000 RWF',
    '200,000 - 500,000 RWF',
    '500,000 - 1,000,000 RWF',
    'Over 1,000,000 RWF',
    'Prefer not to say',
  ];
}
