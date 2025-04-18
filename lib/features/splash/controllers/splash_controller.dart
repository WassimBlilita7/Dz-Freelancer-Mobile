
import '../providers/splash_provider.dart';

class SplashController {
  final SplashProvider provider;

  SplashController(this.provider);

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate initialization
    provider.setLoading(false);
  }
}