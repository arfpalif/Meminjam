import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/homepage/controllers/homepage_controller.dart';
import 'home_quick_action_item.dart';

class HomeQuickAction extends GetView<HomepageController> {
  const HomeQuickAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Quick Action", style: AppTypography.h3),
            TextButton(
              onPressed: () {},
              child: Text("See All", style: AppTypography.subtitle),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeQuickActionItem(
              icon: Icons.add_box,
              label: "New Items",
              onClick: () {
                Get.toNamed(Routes.STOCK_ADD);
              },
            ),
            HomeQuickActionItem(
              icon: Icons.category,
              label: "Items",
              onClick: () {
                controller.changePage(1);
              },
            ),
            HomeQuickActionItem(
              icon: Icons.event_note,
              label: "Transaction",
              onClick: () {},
            ),
            HomeQuickActionItem(
              icon: Icons.qr_code_scanner,
              label: "Scan QR",
              onClick: () {},
            ),
          ],
        ),
      ],
    );
  }
}
