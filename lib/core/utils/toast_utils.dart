import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_toast.dart';

class ToastUtils {
  static void showToast({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: CustomToast(
            message: message,
            isSuccess: isSuccess,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}