import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_text_field.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/controllers/signup_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/signup_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late SignupController _controller;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SignupProvider>(context, listen: false);
    _controller = SignupController(provider, ApiService());
    provider.controller = _controller; // Stocke le controller dans le provider
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDarkGrey,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  SizedBox(height: 8.h),
                  Text(
                    'Rejoignez Wassit Freelancer DZ !',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textLightGrey,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  SizedBox(height: 40.h),
                  CustomTextField(
                    label: 'Nom d\'utilisateur',
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    onChanged: provider.updateUsername,
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 400.ms),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: provider.updateEmail,
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 500.ms),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    label: 'Mot de passe',
                    controller: _passwordController,
                    isPassword: true,
                    onChanged: provider.updatePassword,
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 600.ms),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: provider.model.isFreelancer,
                        onChanged: (value) => provider.toggleFreelancer(value ?? false),
                      ),
                      Text(
                        'Je suis un freelance',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textLightGrey,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 700.ms),
                  SizedBox(height: 30.h),
                  provider.model.isLoading
                      ? CircularProgressIndicator(
                    color: AppColors.primaryBlue,
                  )
                      : GestureDetector(
                    onTap: () => _controller.register(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'S\'inscrire',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
                  if (provider.model.errorMessage != null) ...[
                    SizedBox(height: 20.h),
                    Text(
                      provider.model.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Déjà un compte ? ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textLightGrey,
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToLogin,
                        child: Text(
                          'Connectez-vous ici',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
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