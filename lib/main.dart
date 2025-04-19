import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/config/app_routes.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/login_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/signup_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/providers/onboarding_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/splash/providers/splash_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wassit Freelancer DZ',
            theme: ThemeData(
              primaryColor: AppColors.primaryBlue,
              scaffoldBackgroundColor: AppColors.backgroundLight,
              textTheme: TextTheme(
                bodyLarge: TextStyle(fontSize: 16.sp, color: AppColors.textDarkGrey),
                bodyMedium: TextStyle(fontSize: 14.sp, color: AppColors.textLightGrey),
              ),
            ),
            initialRoute: '/',
            routes: getAppRoutes(),
          );
        },
      ),
    );
  }
}