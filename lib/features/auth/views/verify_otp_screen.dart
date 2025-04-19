import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_text_field.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_button.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/signup_provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  String? _email;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
    _loadEmail();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('signupEmail') ?? '';
    });
  }

  void _onNumberTap(String number) {
    for (int i = 0; i < 6; i++) {
      if (_otpControllers[i].text.isEmpty) {
        _otpControllers[i].text = number;
        if (i < 5) _focusNodes[i + 1].requestFocus();
        break;
      }
    }
  }

  void _onDeleteTap() {
    for (int i = 5; i >= 0; i--) {
      if (_otpControllers[i].text.isNotEmpty) {
        _otpControllers[i].clear();
        _focusNodes[i].requestFocus();
        break;
      }
    }
  }

  void _onVerifyTap(BuildContext context, SignupProvider provider) {
    final otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length == 6) {
      provider.controller?.verifyOtp(context, otp);
    } else {
      provider.setError('Veuillez entrer un OTP complet de 6 chiffres');
    }
  }

  void _onResendTap() {
    // TODO: Implémenter la logique de renvoi d'OTP
    print('Renvoyer l\'OTP');
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 40.w,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        style: AppTextStyles.otpInputText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.textLightGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.textLightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.primaryGreen),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
        keyboardType: TextInputType.none,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
        },
      ),
    );
  }

  Widget _buildNumberButton(String number, {bool isDelete = false, bool isSubmit = false}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: CustomButton(
          title: number,
          onTap: () {
            if (isDelete) {
              _onDeleteTap();
            } else if (isSubmit) {
              _onVerifyTap(context, Provider.of<SignupProvider>(context, listen: false));
            } else {
              _onNumberTap(number);
            }
          },
          backgroundColor: isSubmit ? AppColors.primaryGreen : Colors.grey[200]!,
          textColor: isSubmit ? Colors.white : AppColors.textDarkGrey,
          borderRadius: 8.0,
          icon: isDelete ? Icons.backspace : isSubmit ? Icons.check : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                          'Vérification du Code OTP',
                          style: AppTextStyles.titleLarge,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                        SizedBox(height: 8.h),
                        Text(
                          'Nous avons envoyé un code OTP à votre email\n$_email\nVeuillez entrer le code de 6 chiffres pour vérifier.',
                          style: AppTextStyles.subtitleMedium,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (index) => _buildOtpField(index)),
                        ).animate().slideY(begin: 0.2, end: 0.0, duration: 600.ms, delay: 400.ms),
                        if (provider.model.errorMessage != null) ...[
                          SizedBox(height: 20.h),
                          Text(
                            provider.model.errorMessage!,
                            style: AppTextStyles.errorText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: _onResendTap,
                          child: Text(
                            'Vous n\'avez pas reçu le code ? Renvoyer l\'OTP',
                            style: AppTextStyles.linkSmall,
                          ),
                        ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildNumberButton('1'),
                      _buildNumberButton('2'),
                      _buildNumberButton('3'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildNumberButton('4'),
                      _buildNumberButton('5'),
                      _buildNumberButton('6'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildNumberButton('7'),
                      _buildNumberButton('8'),
                      _buildNumberButton('9'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildNumberButton('', isDelete: true),
                      _buildNumberButton('0'),
                      _buildNumberButton('', isSubmit: true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}