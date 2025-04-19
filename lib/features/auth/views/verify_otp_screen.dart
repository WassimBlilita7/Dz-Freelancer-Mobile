import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_text_field.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/signup_provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupController = Provider.of<SignupProvider>(context, listen: false).controller;

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
                    'Vérifiez votre email',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDarkGrey,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  SizedBox(height: 8.h),
                  Text(
                    'Entrez le code OTP envoyé à votre email',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textLightGrey,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  SizedBox(height: 40.h),
                  CustomTextField(
                    label: 'Code OTP',
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                  ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 400.ms),
                  SizedBox(height: 30.h),
                  provider.model.isLoading
                      ? CircularProgressIndicator(
                    color: AppColors.primaryBlue,
                  )
                      : GestureDetector(
                    onTap: () => signupController!.verifyOtp(context, _otpController.text),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Vérifier',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                  if (provider.model.errorMessage != null) ...[
                    SizedBox(height: 20.h),
                    Text(
                      provider.model.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Retour à l\'inscription',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}