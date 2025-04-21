import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockTab extends StatelessWidget {
  const ClockTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Horloge',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ).animate().fadeIn(duration: 600.ms),
    );
  }
}