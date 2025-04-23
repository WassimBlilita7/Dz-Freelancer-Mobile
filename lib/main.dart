import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/config/app_routes.dart';
import 'package:wassit_freelancer_dz_flutter/core/providers/theme_provider.dart';
import 'package:wassit_freelancer_dz_flutter/core/themes/app_theme.dart';
import 'package:wassit_freelancer_dz_flutter/core/wrappers/splash_wrapper.dart';
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
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'Wassit Freelancer DZ',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme(),
                darkTheme: AppTheme.darkTheme(),
                themeMode: themeProvider.model.themeMode,
                home: const SplashWrapper(),
                routes: getAppRoutes(),
                onGenerateRoute: (settings) {
                  print('onGenerateRoute called for ${settings.name}');
                  return null;
                },
                onUnknownRoute: (settings) {
                  print('onUnknownRoute called for ${settings.name}');
                  return MaterialPageRoute(
                    builder: (context) => const Scaffold(
                      body: Center(child: Text('Route non trouvée')),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}