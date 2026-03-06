import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import '../../controllers/stock_controller.dart';

class StockTabBar extends StatelessWidget {
  const StockTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StockController>();

    return Obx(
      () => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: ColorStyle.neutral3, width: 1),
          ),
        ),
        child: Row(
          children: [
            _buildTab(context, "Items", 0, controller),
            _buildTab(context, "Transactions", 1, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    String title,
    int index,
    StockController controller,
  ) {
    final isActive = controller.currentTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? ColorStyle.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.title.copyWith(
              color: isActive ? ColorStyle.primary : ColorStyle.neutral2,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
