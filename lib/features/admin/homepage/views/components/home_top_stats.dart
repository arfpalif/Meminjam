import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import '../../controllers/homepage_controller.dart';
import 'home_stat_card.dart';

class HomeTopStats extends GetView<HomepageController> {
  const HomeTopStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Top Stats", style: AppTypography.h3),
            TextButton(
              onPressed: controller.fetchStats,
              child: Text("Refresh", style: AppTypography.subtitle),
            ),
          ],
        ),
        Obx(
          () => GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              HomeStatCard(
                title: "All items",
                count: controller.totalItems.value.toString(),
                color: ColorStyle.primary,
                icon: Icons.inventory_2,
              ),
              HomeStatCard(
                title: "Available items",
                count: controller.availableItems.value.toString(),
                color: ColorStyle.success,
                icon: Icons.check_circle,
              ),
              HomeStatCard(
                title: "Borrowed items",
                count: controller.borrowedItems.value.toString(),
                color: ColorStyle.accent,
                icon: Icons.outbox,
              ),
              HomeStatCard(
                title: "Borrow Request",
                count: controller.borrowRequests.value.toString(),
                color: ColorStyle.error,
                icon: Icons.person,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
