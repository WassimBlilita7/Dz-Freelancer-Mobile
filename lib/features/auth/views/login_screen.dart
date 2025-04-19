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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LoginProvider>(context, listen: false);
    _controller = LoginController(provider, ApiService());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Logo en arrière-plan avec opacité
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu principal
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.getText(context),
                        ),
                      ).animate().fadeIn(duration: 600.ms),
                      SizedBox(height: 40.h),
                      CustomTextField(
                        label: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: provider.updateEmail,
                      ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        label: 'Mot de passe',
                        controller: _passwordController,
                        isPassword: true,
                        onChanged: provider.updatePassword,
                      ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 200.ms),
                      SizedBox(height: 30.h),
                      provider.model.isLoading
                          ? CircularProgressIndicator(
                        color: AppColors.getPrimary(context),
                      )
                          : ElevatedButton(
                        onPressed: () => _controller.login(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.getPrimary(context),
                          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Se connecter',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                      ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                      if (provider.model.errorMessage != null) ...[
                        SizedBox(height: 20.h),
                        Text(
                          provider.model.errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}