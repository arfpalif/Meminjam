import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/homepage/controllers/homepage_controller.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class HomeBanner extends GetView<HomepageController> {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorStyle.neutral3.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('src/images/logo.png', height: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Meminjam",
                    style: AppTypography.title.copyWith(
                      color: ColorStyle.primary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Obx(
                () => Text(
                  controller.isLoading.value
                      ? "Memuat..."
                      : "Selamat datang\n${controller.userProfile.value?.name ?? 'Pengguna'}",
                  style: AppTypography.h2,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset('src/images/banner.png', height: 100),
          ),
        ],
      ),
    );
  }
}
