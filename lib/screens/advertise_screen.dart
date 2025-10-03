import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class AdvertiseScreen extends StatefulWidget {
  const AdvertiseScreen({super.key});

  @override
  State<AdvertiseScreen> createState() => _AdvertiseScreenState();
}

class _AdvertiseScreenState extends State<AdvertiseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _budgetController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isLoading = false;
  String _selectedBusinessType = '';
  String _selectedAdvertisingGoal = '';
  String _selectedBudgetRange = '';
  String _selectedPreferredTime = '';
  List<String> _selectedTargetAudience = [];

  final List<String> _businessTypes = [
    'Retail/Commerce',
    'Restaurant/Food',
    'Healthcare',
    'Education',
    'Technology',
    'Real Estate',
    'Automotive',
    'Banking/Finance',
    'Non-Profit',
    'Government',
    'Other',
  ];

  final List<String> _advertisingGoals = [
    'Brand Awareness',
    'Product Launch',
    'Event Promotion',
    'Lead Generation',
    'Sales Increase',
    'Community Engagement',
    'Other',
  ];

  final List<String> _budgetRanges = [
    'Under 100,000 RWF',
    '100,000 - 500,000 RWF',
    '500,000 - 1,000,000 RWF',
    '1,000,000 - 2,000,000 RWF',
    '2,000,000 - 5,000,000 RWF',
    'Over 5,000,000 RWF',
  ];

  final List<String> _preferredTimes = [
    'Morning (6 AM - 12 PM)',
    'Afternoon (12 PM - 6 PM)',
    'Evening (6 PM - 12 AM)',
    'Any Time',
    'Weekends Only',
  ];

  final List<String> _targetAudience = [
    'Youth (18-25)',
    'Young Adults (26-35)',
    'Middle-aged (36-50)',
    'Seniors (50+)',
    'Families',
    'Professionals',
    'Students',
    'General Public',
  ];

  @override
  void dispose() {
    _businessNameController.dispose();
    _contactNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _budgetController.dispose();
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
              'Thank you! We\'ll contact you within 24 hours.',
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
                        FontAwesomeIcons.bullhorn,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Advertise with Us', style: AppTheme.heading3),
                          Text(
                            'Promote your business on KT Radio',
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
                        // Benefits Card
                        CustomCard(
                          child: Column(
                            children: [
                              Icon(
                                FontAwesomeIcons.star,
                                color: AppTheme.primaryColor,
                                size: 40,
                              ),
                              const SizedBox(height: AppTheme.spacingM),
                              Text(
                                'Why Advertise with KT Radio?',
                                style: AppTheme.heading4,
                              ),
                              const SizedBox(height: AppTheme.spacingS),
                              Text(
                                'Reach thousands of listeners across Rwanda with our professional advertising solutions.',
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
                                      FontAwesomeIcons.users,
                                      'Large Audience',
                                      'Thousands of listeners',
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildBenefitItem(
                                      FontAwesomeIcons.bullseye,
                                      'Targeted Reach',
                                      'Specific demographics',
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildBenefitItem(
                                      FontAwesomeIcons.chartLine,
                                      'Proven Results',
                                      'Track your success',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacingL),

                        // Business Information
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Business Information',
                                style: AppTheme.heading4,
                              ),
                              const SizedBox(height: AppTheme.spacingM),

                              // Business Name
                              CustomTextField(
                                controller: _businessNameController,
                                label: 'Business Name',
                                prefixIcon: FontAwesomeIcons.building,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your business name';
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

                        // Advertising Details
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Advertising Details',
                                style: AppTheme.heading4,
                              ),
                              const SizedBox(height: AppTheme.spacingM),

                              // Business Type
                              _buildDropdownField(
                                'Business Type',
                                FontAwesomeIcons.briefcase,
                                _businessTypes,
                                _selectedBusinessType,
                                (value) => setState(
                                  () => _selectedBusinessType = value!,
                                ),
                              ),

                              const SizedBox(height: AppTheme.spacingM),

                              // Advertising Goal
                              _buildDropdownField(
                                'Advertising Goal',
                                FontAwesomeIcons.bullseye,
                                _advertisingGoals,
                                _selectedAdvertisingGoal,
                                (value) => setState(
                                  () => _selectedAdvertisingGoal = value!,
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

                              // Preferred Time
                              _buildDropdownField(
                                'Preferred Time',
                                FontAwesomeIcons.clock,
                                _preferredTimes,
                                _selectedPreferredTime,
                                (value) => setState(
                                  () => _selectedPreferredTime = value!,
                                ),
                              ),

                              const SizedBox(height: AppTheme.spacingM),

                              // Target Audience
                              Text(
                                'Target Audience (Select all that apply)',
                                style: AppTheme.bodyLarge.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: AppTheme.spacingS),
                              _buildMultiSelectChips(
                                _targetAudience,
                                _selectedTargetAudience,
                                (value) {
                                  setState(() {
                                    if (_selectedTargetAudience.contains(
                                      value,
                                    )) {
                                      _selectedTargetAudience.remove(value);
                                    } else {
                                      _selectedTargetAudience.add(value);
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
                                'Additional Information',
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
                                  maxLines: 4,
                                  style: AppTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Tell us about your advertising needs',
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
                          text: 'Submit Advertising Request',
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
