import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_text_field.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_button.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/controllers/login_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController _controller;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LoginProvider>(context, listen: false);
    _controller = LoginController(provider, ApiService());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _navigateToSignup() {
    Navigator.pushNamed(context, '/signup');
  }

  void _handleGoogleLogin() {
    print('Connexion Google');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Consumer<LoginProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/wassim.png',
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.contain,
                  ).animate().fadeIn(duration: 800.ms),
                  SizedBox(height: 20.h),
                  Text(
                    'Bienvenue de nouveau !',
                    style: AppTextStyles.titleLarge(context),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  SizedBox(height: 8.h),
                  Text(
                    'Connectez-vous à votre compte',
                    style: AppTextStyles.subtitleMedium(context),
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  SizedBox(height: 40.h),
                  CustomTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: provider.updateEmail,
                    prefixIcon: Icons.email,
                    prefixIconColor: AppColors.textLightGrey,
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 400.ms),
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
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 500.ms),
                  SizedBox(height: 30.h),
                  CustomButton(
                    title: 'Se connecter',
                    onTap: () => _controller.login(context),
                    backgroundColor: AppColors.primaryGreen,
                    textColor: Colors.white,
                    borderRadius: 24.0,
                    isLoading: provider.model.isLoading,
                  ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: _handleGoogleLogin,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primaryGreen,
                          width: 1.w,
                        ),
                        boxShadow: AppColors.cardBoxShadow,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/google.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Se connecter avec Google',
                            style: AppTextStyles.buttonText(context).copyWith(
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 700.ms),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vous n\'avez pas de compte ? ',
                        style: AppTextStyles.labelSmall(context),
                      ),
                      GestureDetector(
                        onTap: _navigateToSignup,
                        child: Text(
                          'Register',
                          style: AppTextStyles.linkSmall(context),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}