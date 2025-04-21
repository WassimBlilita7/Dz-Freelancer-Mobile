import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle,
            size: 100.sp,
            color: Theme.of(context).colorScheme.primary,
          ).animate().fadeIn(duration: 600.ms),
          SizedBox(height: 20.h),
          Text(
            'Profil Utilisateur',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
        ],
      ),
    );
  }
}