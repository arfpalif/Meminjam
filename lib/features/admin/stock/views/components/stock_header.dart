import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/stock/controllers/stock_controller.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/shared/widgets/buttons/primary_btn.dart';

class StockHeader extends GetView<StockController> {
  StockHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Meminjam', style: AppTypography.h1.copyWith(fontSize: 28)),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  size: 28,
                  color: ColorStyle.neutral1,
                ),
              ),
              const SizedBox(width: 8),
              Obx(
                () => PrimaryBtn(
                  text: controller.currentTab.value == 0
                      ? "Add Items"
                      : "Add Transaction",
                  onPressed: () {
                    if (controller.currentTab.value == 0) {
                      Get.toNamed(Routes.STOCK_ADD);
                    } else {
                      Get.toNamed(Routes.LOAN_FORM);
                    }
                  },
                  height: 55,
                  borderRadius: 20,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
