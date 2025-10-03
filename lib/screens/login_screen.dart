import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';
import 'registration_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';
import '../services/translation_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', _emailController.text);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.spacingXXL),

                // Logo and Title
                CustomCard(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: AppTheme.shadowGlow,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/kt_logo.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to icon if image not found
                              return const Icon(
                                FontAwesomeIcons.radio,
                                color: Colors.white,
                                size: 50,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingL),
                      Text('App Name'.tr, style: AppTheme.heading2),
                      const SizedBox(height: AppTheme.spacingS),
                      Text(
                        'Radio Tagline'.tr,
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXXL),

                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email Address'.tr,
                        hint: 'Enter Your Email'.tr,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email'.tr;
                          }
                          if (!value.contains('@')) {
                            return 'Please Enter Valid Email'.tr;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password'.tr,
                        hint: 'Enter Your Password'.tr,
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppTheme.textSecondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password'.tr;
                          }
                          if (value.length < 6) {
                            return 'Password Min Length'.tr;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: AppTheme.spacingXL),

                      CustomButton(
                        text: 'login'.tr,
                        onPressed: _isLoading ? null : _login,
                        isLoading: _isLoading,
                        icon: FontAwesomeIcons.rightToBracket,
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      CustomButton(
                        text: 'Create Account'.tr,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            ),
                          );
                        },
                        isPrimary: true,
                        icon: FontAwesomeIcons.userPlus,
                      ),

                      const SizedBox(height: AppTheme.spacingL),

                      TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', false);
                          if (mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Continue As Guest'.tr,
                          style: AppTheme.bodyLarge.copyWith(
                            color: AppTheme.textSecondary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXXL),

                // Features Preview
                CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSectionHeader(
                        title: 'What you\'ll get:',
                        icon: FontAwesomeIcons.star,
                      ),
                      const SizedBox(height: AppTheme.spacingM),
                      _buildFeatureItem(
                        FontAwesomeIcons.radio,
                        'Live Radio Streaming',
                        'Listen to KT Radio 96.7 FM live',
                      ),
                      const SizedBox(height: AppTheme.spacingM),
                      _buildFeatureItem(
                        FontAwesomeIcons.calendar,
                        'Show Schedules & Programs',
                        'Never miss your favorite shows',
                      ),
                      const SizedBox(height: AppTheme.spacingM),
                      _buildFeatureItem(
                        FontAwesomeIcons.newspaper,
                        'Latest News & Updates',
                        'Stay informed with local news',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 20),
        ),
        const SizedBox(width: AppTheme.spacingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
