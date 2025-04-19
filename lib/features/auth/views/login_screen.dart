import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_text_field.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/controllers/login_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/login_provider.dart';

import '../../../core/services/api_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController _controller;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LoginProvider>(context, listen: false);
    _controller = LoginController(provider, ApiService());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToSignup() {
    // TODO: Implémenter la navigation vers l'écran d'inscription
    // Navigator.pushNamed(context, '/signup');
  }

  void _handleGoogleLogin() {
    // TODO: Implémenter la connexion Google
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
                  // Logo
                  Image.asset(
                    'assets/images/logo.png',
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.contain,
                  ).animate().fadeIn(duration: 800.ms),
                  SizedBox(height: 20.h),
                  // Titre
                  Text(
                    'Bienvenue de nouveau !',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDarkGrey,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  SizedBox(height: 8.h),
                  // Sous-titre
                  Text(
                    'Connectez-vous à votre compte',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textLightGrey,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  SizedBox(height: 40.h),
                  // Champ Nom d'utilisateur
                  CustomTextField(
                    label: 'Email',
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    onChanged: provider.updateEmail, // À ajuster si l'API utilise username
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 400.ms),
                  SizedBox(height: 20.h),
                  // Champ Mot de passe
                  CustomTextField(
                    label: 'Mot de passe',
                    controller: _passwordController,
                    isPassword: true,
                    onChanged: provider.updatePassword,
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 500.ms),
                  SizedBox(height: 30.h),
                  // Bouton Se connecter
                  provider.model.isLoading
                      ? CircularProgressIndicator(
                    color: AppColors.primaryBlue,
                  )
                      : GestureDetector(
                    onTap: () => _controller.login(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Se connecter',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
                  if (provider.model.errorMessage != null) ...[
                    SizedBox(height: 20.h),
                    Text(
                      provider.model.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 30.h),
                  // Bouton Se connecter avec Google
                  GestureDetector(
                    onTap: _handleGoogleLogin,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primaryBlue,
                          width: 1.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
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
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 700.ms),
                  SizedBox(height: 30.h),
                  // Lien d'inscription
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vous n\'avez pas de compte ? ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textLightGrey,
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToSignup,
                        child: Text(
                          'Inscrivez-vous ici',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
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