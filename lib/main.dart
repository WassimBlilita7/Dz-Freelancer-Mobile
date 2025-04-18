import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/splash/providers/splash_provider.dart';
import 'features/splash/views/splash_screen.dart';
import 'features/onboarding/providers/onboarding_provider.dart';
import 'features/onboarding/views/onboarding_screen.dart';

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
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => const Scaffold(body: Center(child: Text('Home Screen'))),
        },
      ),
    );
  }
}