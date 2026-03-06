import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import '../../../../../configs/routes/route.dart';

class SuccessBottomSheet extends StatelessWidget {
  final String? name;
  final String? message;
  final String? subMessage;
  const SuccessBottomSheet({
    super.key,
    this.name,
    this.message,
    this.subMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: ColorStyle.neutral3,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 200,
            child: Icon(
              Icons.celebration,
              size: 100,
              color: ColorStyle.primary,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            message ?? 'Your account successfully created!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorStyle.neutral1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subMessage ??
                'Your account has successfully created. You can go to login page first to login into your account!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: ColorStyle.neutral2),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.HOME),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyle.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Yay! Continue',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
