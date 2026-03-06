import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/stock/controllers/stock_controller.dart';
import 'package:meminjam/features/admin/stock/models/stock_model.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/shared/widgets/buttons/icon_primary_btn.dart';

class ItemDetailPage extends GetView<StockController> {
  const ItemDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final StockModel item = Get.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyle.neutral1),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: ColorStyle.neutral1),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: ColorStyle.neutral3.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Hero(
                      tag: item.id,
                      child: const Icon(
                        Icons.book,
                        size: 150,
                        color: ColorStyle.neutral2,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 40,
                  child: Column(
                    children: [
                      IconPrimaryBtn(
                        icon: Icons.delete_outline,
                        label: "Delete",
                        textColor: Colors.white,
                        color: ColorStyle.primary,
                        onTap: () => controller.deleteItem(item.id),
                      ),
                      const SizedBox(height: 12),
                      IconPrimaryBtn(
                        textColor: Colors.white,
                        icon: Icons.edit_outlined,
                        label: "Edit",
                        color: ColorStyle.primary,
                        onTap: () {
                          controller.setEditData(item);
                          Get.toNamed(
                            Routes.STOCK_ADD,
                            arguments: {'isEdit': true},
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorStyle.neutral3),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.category_outlined,
                          size: 16,
                          color: ColorStyle.neutral1,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.category,
                          style: AppTypography.subtitle.copyWith(
                            color: ColorStyle.neutral1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(item.name, style: AppTypography.h1),
                  const SizedBox(height: 24),

                  Container(height: 1, color: ColorStyle.neutral3),
                  const SizedBox(height: 20),

                  _buildDetailRow(
                    "Stock",
                    "${item.availableStock}/${item.totalStock} items",
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow("Borrowed by", "0 people"),
                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorStyle.neutral3),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "View more detail",
                        style: AppTypography.title.copyWith(
                          color: ColorStyle.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.startChat(item.id),
        backgroundColor: ColorStyle.primary,
        child: const Icon(
          Icons.chat_bubble_outline_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.subtitle.copyWith(
            color: ColorStyle.neutral2,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: AppTypography.title.copyWith(
            color: ColorStyle.neutral1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
