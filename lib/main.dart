import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/config/app_routes.dart';
import 'package:wassit_freelancer_dz_flutter/core/middleware/auth_middleware.dart';
import 'package:wassit_freelancer_dz_flutter/core/providers/theme_provider.dart';
import 'package:wassit_freelancer_dz_flutter/core/themes/app_theme.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/login_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/signup_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/views/login_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/views/home_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/providers/onboarding_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/views/onboarding_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/splash/providers/splash_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/splash/views/splash_screen.dart';

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

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthWrapper()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _hasSeenOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final authMiddleware = AuthMiddleware();
    final isLoggedIn = await authMiddleware.isUserLoggedIn();
    final hasSeenOnboarding = await authMiddleware.hasSeenOnboarding();

    if (isLoggedIn) {
      final authData = await authMiddleware.getAuthData();
      if (authData != null) {
        final loginProvider = Provider.of<LoginProvider>(context, listen: false);
        loginProvider.setUserData(context, authData['userData'], authData['token']);
      }
    }

    setState(() {
      _isLoggedIn = isLoggedIn;
      _hasSeenOnboarding = hasSeenOnboarding;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_hasSeenOnboarding) {
      return const OnboardingScreen();
    }

    return _isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}