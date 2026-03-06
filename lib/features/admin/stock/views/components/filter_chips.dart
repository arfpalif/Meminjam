import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/stock/controllers/stock_controller.dart';
import 'package:meminjam/shared/styles/color_style.dart';

Widget buildFilterChips(StockController controller) {
  final filters = ["All Items", "Items Remaining", "On borrow"];

  return Row(
    children: [
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(filters.length, (index) {
              return Obx(() {
                final isSelected = controller.selectedFilter.value == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(filters[index]),
                    selected: isSelected,
                    onSelected: (selected) => controller.changeFilter(index),
                    selectedColor: ColorStyle.primary,
                    backgroundColor: ColorStyle.neutral3,
                    labelStyle: AppTypography.caption.copyWith(
                      color: isSelected ? Colors.white : ColorStyle.neutral1,
                    ),
                  ),
                );
              });
            }),
          ),
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.tune, color: ColorStyle.primary),
      ),
    ],
  );
}
