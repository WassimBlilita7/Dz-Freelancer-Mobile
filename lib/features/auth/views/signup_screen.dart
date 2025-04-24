import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_text_field.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_button.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/controllers/signup_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/signup_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late SignupController _controller;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SignupProvider>(context, listen: false);
    _controller = SignupController(provider, ApiService());
    provider.controller = _controller;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _navigateToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Consumer<SignupProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.contain,
                  ).animate().fadeIn(duration: 800.ms),
                  SizedBox(height: 20.h),
                  Text(
                    'Créer un compte',
                    style: AppTextStyles.titleLarge(context),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  SizedBox(height: 8.h),
                  Text(
                    'Rejoignez Wassit Freelancer DZ !',
                    style: AppTextStyles.subtitleMedium(context),
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  SizedBox(height: 40.h),
                  CustomTextField(
                    label: 'Nom d\'utilisateur',
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    onChanged: provider.updateUsername,
                    prefixIcon: Icons.person,
                    prefixIconColor: AppColors.textLightGrey,
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 400.ms),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: provider.updateEmail,
                    prefixIcon: Icons.email,
                    prefixIconColor: AppColors.textLightGrey,
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 500.ms),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    label: 'Mot de passe',
                    controller: _passwordController,
                    isPassword: true,
                    obscureText: !_isPasswordVisible,
                    onChanged: provider.updatePassword,
                    prefixIcon: Icons.lock,
                    prefixIconColor: AppColors.textLightGrey,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textLightGrey,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 600.ms),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    label: 'Confirmer le mot de passe',
                    controller: _confirmPasswordController,
                    isPassword: true,
                    obscureText: !_isConfirmPasswordVisible,
                    onChanged: provider.updateConfirmPassword,
                    prefixIcon: Icons.lock,
                    prefixIconColor: AppColors.textLightGrey,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textLightGrey,
                      ),
                      onPressed: _toggleConfirmPasswordVisibility,
                    ),
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 650.ms),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: provider.model.isFreelancer,
                        onChanged: (value) => provider.toggleFreelancer(value ?? false),
                        activeColor: AppColors.primaryGreen,
                        checkColor: Colors.white,
                      ),
                      Text(
                        'Je suis un freelance',
                        style: AppTextStyles.labelSmall(context),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 700.ms),
                  SizedBox(height: 30.h),
                  CustomButton(
                    title: 'S\'inscrire',
                    onTap: () => _controller.register(context),
                    backgroundColor: AppColors.primaryGreen,
                    textColor: Colors.white,
                    borderRadius: 24.0,
                    isLoading: provider.model.isLoading,
                  ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Déjà un compte ? ',
                        style: AppTextStyles.labelSmall(context),
                      ),
                      GestureDetector(
                        onTap: _navigateToLogin,
                        child: Text(
                          'Connectez-vous ici',
                          style: AppTextStyles.linkSmall(context),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 900.ms),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}