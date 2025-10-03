import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class PartnershipScreen extends StatefulWidget {
  const PartnershipScreen({super.key});

  @override
  State<PartnershipScreen> createState() => _PartnershipScreenState();
}

class _PartnershipScreenState extends State<PartnershipScreen> {
  final _formKey = GlobalKey<FormState>();
  final _organizationNameController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isLoading = false;
  String _selectedPartnershipType = '';
  String _selectedOrganizationType = '';
  String _selectedBudgetRange = '';
  String _selectedDuration = '';
  List<String> _selectedInterests = [];

  final List<String> _partnershipTypes = [
    'Content Collaboration',
    'Event Partnership',
    'Sponsorship',
    'Media Partnership',
    'Community Outreach',
    'Educational Partnership',
    'Technology Partnership',
    'Other',
  ];

  final List<String> _organizationTypes = [
    'Government Agency',
    'Non-Profit Organization',
    'Educational Institution',
    'Private Company',
    'International Organization',
    'Community Group',
    'Religious Organization',
    'Other',
  ];

  final List<String> _budgetRanges = [
    'No Budget (In-kind support)',
    'Under 500,000 RWF',
    '500,000 - 1,000,000 RWF',
    '1,000,000 - 2,000,000 RWF',
    '2,000,000 - 5,000,000 RWF',
    'Over 5,000,000 RWF',
  ];

  final List<String> _durations = [
    'One-time Event',
    '3 Months',
    '6 Months',
    '1 Year',
    '2+ Years',
    'Ongoing',
  ];

  final List<String> _interestAreas = [
    'Youth Development',
    'Education',
    'Health & Wellness',
    'Environment',
    'Technology',
    'Arts & Culture',
    'Sports',
    'Community Development',
    'Women Empowerment',
    'Economic Development',
  ];

  @override
  void dispose() {
    _organizationNameController.dispose();
    _contactNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Thank you! We\'ll review your partnership proposal and get back to you soon.',
              style: AppTheme.bodyMedium.copyWith(color: Colors.white),
            ),
            backgroundColor: AppTheme.primaryColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error submitting form. Please try again.',
              style: AppTheme.bodyMedium.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
                        FontAwesomeIcons.handshake,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Partnership Opportunities',
                            style: AppTheme.heading3,
                          ),
                          Text(
                            'Collaborate with KT Radio for mutual growth',
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
                        FontAwesomeIcons.xmark,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Form
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Partnership Benefits
                        CustomCard(
                          child: Column(
                            children: [
                              Icon(
                                FontAwesomeIcons.users,
                                color: AppTheme.primaryColor,
                                size: 40,
                              ),
                              const SizedBox(height: AppTheme.spacingM),
                              Text(
                                'Why Partner with KT Radio?',
                                style: AppTheme.heading4,
                              ),
                              const SizedBox(height: AppTheme.spacingS),
                              Text(
                                'Join forces with Rwanda\'s leading radio station to create meaningful impact in our community.',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppTheme.spacingM),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildBenefitItem(
                                      FontAwesomeIcons.heart,
                                      'Community Impact',
                                      'Make a difference',
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildBenefitItem(
                                      FontAwesomeIcons.globe,
                                      'Wide Reach',
                                      'National coverage',
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildBenefitItem(
                                      FontAwesomeIcons.star,
                                      'Brand Association',
                                      'Trusted platform',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacingL),

                        // Partnership Types
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Partnership Types',
                                style: AppTheme.heading4,
                              ),
                              const SizedBox(height: AppTheme.spacingM),
                              Text(
                                'Select the type of partnership you\'re interested in:',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              const SizedBox(height: AppTheme.spacingM),
                              _buildPartnershipTypeGrid(),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacingL),

                        // Organization Information
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Organization Information',
                                style: AppTheme.heading4,
                              ),
                              const SizedBox(height: AppTheme.spacingM),

                              // Organization Name
                              CustomTextField(
                                controller: _organizationNameController,
                                label: 'Organization Name',
                                prefixIcon: FontAwesomeIcons.building,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your organization name';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: AppTheme.spacingM),

                              // Contact Name
                              CustomTextField(
                                controller: _contactNameController,
                                label: 'Contact Person Name',
                                prefixIcon: FontAwesomeIcons.user,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter contact person name';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: AppTheme.spacingM),

                              // Email
                              CustomTextField(
                                controller: _emailController,
                                label: 'Email Address',
                                prefixIcon: FontAwesomeIcons.envelope,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: AppTheme.spacingM),

                              // Phone
                              CustomTextField(
                                controller: _phoneController,
                                label: 'Phone Number',
                                prefixIcon: FontAwesomeIcons.phone,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: AppTheme.spacingM),

                              // Website
                              CustomTextField(
                                controller: _websiteController,
                                label: 'Website (Optional)',
                                prefixIcon: FontAwesomeIcons.globe,
                                keyboardType: TextInputType.url,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacingL),

                        // Partnership Details
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Partnership Details',
                                style: AppTheme.heading4,
                              ),
                              const SizedBox(height: AppTheme.spacingM),

                              // Organization Type
                              _buildDropdownField(
                                'Organization Type',
                                FontAwesomeIcons.building,
                                _organizationTypes,
                                _selectedOrganizationType,
                                (value) => setState(
                                  () => _selectedOrganizationType = value!,
                                ),
                              ),

                              const SizedBox(height: AppTheme.spacingM),

                              // Budget Range
                              _buildDropdownField(
                                'Budget Range',
                                FontAwesomeIcons.moneyBill,
                                _budgetRanges,
                                _selectedBudgetRange,
                                (value) => setState(
                                  () => _selectedBudgetRange = value!,
                                ),
                              ),

                              const SizedBox(height: AppTheme.spacingM),

                              // Duration
                              _buildDropdownField(
                                'Partnership Duration',
                                FontAwesomeIcons.calendar,
                                _durations,
                                _selectedDuration,
                                (value) =>
                                    setState(() => _selectedDuration = value!),
                              ),

                              const SizedBox(height: AppTheme.spacingM),

                              // Interest Areas
                              Text(
                                'Areas of Interest (Select all that apply)',
                                style: AppTheme.bodyLarge.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: AppTheme.spacingS),
                              _buildMultiSelectChips(
                                _interestAreas,
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
                            ],
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacingL),

                        // Additional Information
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Partnership Proposal',
                                style: AppTheme.heading4,
                              ),
                              const SizedBox(height: AppTheme.spacingM),

                              // Message
                              Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundCard,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: AppTheme.borderLight,
                                    width: 1,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _messageController,
                                  maxLines: 5,
                                  style: AppTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Tell us about your partnership proposal and how we can work together',
                                    labelStyle: AppTheme.bodyLarge.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.comment,
                                      color: AppTheme.textSecondary,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacingL),

                        // Submit Button
                        CustomButton(
                          text: 'Submit Partnership Proposal',
                          onPressed: _isLoading ? null : _submitForm,
                          isLoading: _isLoading,
                          icon: FontAwesomeIcons.paperPlane,
                        ),

                        const SizedBox(height: AppTheme.spacingXXL),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 20),
        const SizedBox(height: AppTheme.spacingXS),
        Text(
          title,
          style: AppTheme.caption.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: AppTheme.caption.copyWith(
            color: AppTheme.textSecondary,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPartnershipTypeGrid() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          _partnershipTypes.map((type) {
            final isSelected = _selectedPartnershipType == type;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPartnershipType = type;
                });
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 80) / 2,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? AppTheme.primaryColor
                          : AppTheme.backgroundCard,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        isSelected
                            ? AppTheme.primaryColor
                            : AppTheme.borderLight,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      _getPartnershipIcon(type),
                      color: isSelected ? Colors.white : AppTheme.primaryColor,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      type,
                      style: AppTheme.bodySmall.copyWith(
                        color: isSelected ? Colors.white : AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  IconData _getPartnershipIcon(String type) {
    switch (type) {
      case 'Content Collaboration':
        return FontAwesomeIcons.fileText;
      case 'Event Partnership':
        return FontAwesomeIcons.calendar;
      case 'Sponsorship':
        return FontAwesomeIcons.star;
      case 'Media Partnership':
        return FontAwesomeIcons.broadcastTower;
      case 'Community Outreach':
        return FontAwesomeIcons.hands;
      case 'Educational Partnership':
        return FontAwesomeIcons.graduationCap;
      case 'Technology Partnership':
        return FontAwesomeIcons.laptop;
      default:
        return FontAwesomeIcons.handshake;
    }
  }

  Widget _buildDropdownField(
    String label,
    IconData icon,
    List<String> options,
    String selected,
    ValueChanged<String?> onChanged,
  ) {
    return Row(
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
                label,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppTheme.spacingXS),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundCard,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppTheme.borderLight, width: 1),
                ),
                child: DropdownButton<String>(
                  value: selected.isEmpty ? null : selected,
                  isExpanded: true,
                  underline: Container(),
                  style: AppTheme.bodyMedium,
                  hint: Text(
                    'Select $label',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  items:
                      options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMultiSelectChips(
    List<String> options,
    List<String> selected,
    ValueChanged<String> onTap,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          options.map((option) {
            final isSelected = selected.contains(option);
            return GestureDetector(
              onTap: () => onTap(option),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? AppTheme.primaryColor
                          : AppTheme.backgroundCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                        isSelected
                            ? AppTheme.primaryColor
                            : AppTheme.borderLight,
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
                    if (isSelected) const SizedBox(width: 6),
                    Text(
                      option,
                      style: AppTheme.caption.copyWith(
                        color:
                            isSelected ? Colors.white : AppTheme.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
