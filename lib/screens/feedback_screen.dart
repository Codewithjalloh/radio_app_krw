import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/custom_widgets.dart';
import '../theme/app_theme.dart';
import '../services/translation_service.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  String _feedbackType = 'Show Feedback';
  String _rating = '5';
  bool _isAnonymous = false;
  bool _allowContact = false;

  final List<String> _feedbackTypes = [
    'Show Feedback',
    'App Experience',
    'Technical Issue',
    'Suggestion',
    'General Feedback',
  ];

  final List<String> _ratings = ['1', '2', '3', '4', '5'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically send the feedback to your backend
      // For now, we'll just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Feedback Submitted Successfully'.tr),
          backgroundColor: AppTheme.secondaryColor,
          duration: const Duration(seconds: 3),
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
      setState(() {
        _feedbackType = 'Show Feedback';
        _rating = '5';
        _isAnonymous = false;
        _allowContact = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        title: Text('Feedback'.tr),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.commentDots,
                            color: AppTheme.primaryColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Share Your Feedback'.tr,
                                style: AppTheme.heading3.copyWith(
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Help us improve KT Radio by sharing your thoughts and suggestions'
                                    .tr,
                                style: AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Feedback Type Selection
              Text(
                'Feedback Type'.tr,
                style: AppTheme.heading4.copyWith(color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    _feedbackTypes.map((type) {
                      final isSelected = _feedbackType == type;
                      return GestureDetector(
                        onTap: () => setState(() => _feedbackType = type),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
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
                            ),
                          ),
                          child: Text(
                            type.tr,
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
                      );
                    }).toList(),
              ),

              const SizedBox(height: 24),

              // Rating Section
              if (_feedbackType == 'Show Feedback' ||
                  _feedbackType == 'App Experience') ...[
                Text(
                  'Rating'.tr,
                  style: AppTheme.heading4.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children:
                      _ratings.map((rating) {
                        final isSelected = _rating == rating;
                        return GestureDetector(
                          onTap: () => setState(() => _rating = rating),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppTheme.primaryColor
                                      : AppTheme.backgroundCard,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? AppTheme.primaryColor
                                        : AppTheme.borderLight,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FontAwesomeIcons.star,
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : AppTheme.textSecondary,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  rating,
                                  style: AppTheme.bodyMedium.copyWith(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : AppTheme.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 24),
              ],

              // Personal Information
              Text(
                'Personal Information'.tr,
                style: AppTheme.heading4.copyWith(color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _nameController,
                label: 'Full Name'.tr,
                hint: 'Enter your full name'.tr,
                prefixIcon: FontAwesomeIcons.user,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name'.tr;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              CustomTextField(
                controller: _emailController,
                label: 'Email Address'.tr,
                hint: 'Enter your email address'.tr,
                prefixIcon: FontAwesomeIcons.envelope,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'.tr;
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email'.tr;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              CustomTextField(
                controller: _subjectController,
                label: 'Subject'.tr,
                hint: 'Brief description of your feedback'.tr,
                prefixIcon: FontAwesomeIcons.tag,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject'.tr;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Message
              Text(
                'Your Message'.tr,
                style: AppTheme.heading4.copyWith(color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.backgroundCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderLight),
                ),
                child: TextFormField(
                  controller: _messageController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText:
                        'Tell us about your experience, suggestions, or any issues you encountered...'
                            .tr,
                    hintStyle: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message'.tr;
                    }
                    if (value.length < 10) {
                      return 'Message must be at least 10 characters'.tr;
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Options
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Options'.tr,
                      style: AppTheme.heading4.copyWith(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Anonymous feedback
                    Row(
                      children: [
                        Checkbox(
                          value: _isAnonymous,
                          onChanged:
                              (value) =>
                                  setState(() => _isAnonymous = value ?? false),
                          activeColor: AppTheme.primaryColor,
                        ),
                        Expanded(
                          child: Text(
                            'Submit anonymously'.tr,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Allow contact
                    Row(
                      children: [
                        Checkbox(
                          value: _allowContact,
                          onChanged:
                              (value) => setState(
                                () => _allowContact = value ?? false,
                              ),
                          activeColor: AppTheme.primaryColor,
                        ),
                        Expanded(
                          child: Text(
                            'Allow us to contact you for follow-up'.tr,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Submit Button
              CustomButton(
                text: 'Submit Feedback'.tr,
                onPressed: _submitFeedback,
                isPrimary: true,
                icon: FontAwesomeIcons.paperPlane,
              ),

              const SizedBox(height: 16),

              // Help Text
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.infoCircle,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your feedback helps us improve KT Radio. We read every message and appreciate your input!'
                            .tr,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
