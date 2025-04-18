import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/config/app_routes.dart';
import 'package:wassit_freelancer_dz_flutter/features/splash/providers/splash_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/providers/onboarding_provider.dart';

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
      ],
      child: MaterialApp(
        title: 'Wassit Freelancer DZ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: '/splash',
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}