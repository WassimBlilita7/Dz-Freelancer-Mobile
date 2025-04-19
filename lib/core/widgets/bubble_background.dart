import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';

class BubbleBackground extends StatelessWidget {
  const BubbleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 300.h), // Hauteur responsive pour les bulles
      painter: BubblePainter(),
    );
  }
}

class BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = AppColors.bubbleColor1.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = AppColors.bubbleColor2.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = AppColors.bubbleColor3.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // Bulle 1 (gauche)
    canvas.drawCircle(
      Offset(50.w, 100.h),
      80.w,
      paint1,
    );

    // Bulle 2 (centre-droit)
    canvas.drawCircle(
      Offset(size.width - 100.w, 50.h),
      60.w,
      paint2,
    );

    // Bulle 3 (haut-droit)
    canvas.drawCircle(
      Offset(size.width - 50.w, 150.h),
      70.w,
      paint3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}