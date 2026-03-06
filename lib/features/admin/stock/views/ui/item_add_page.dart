import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/stock/controllers/stock_controller.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/shared/widgets/buttons/primary_btn.dart';
import 'package:meminjam/shared/widgets/textfields/outline_textfields.dart';

class ItemAddPage extends GetView<StockController> {
  const ItemAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get isEdit parameter from arguments (default: false)
    final bool isEdit = Get.arguments?['isEdit'] ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyle.neutral1),
          onPressed: () {
            controller.clearForm();
            Get.back();
          },
        ),
        title: Text(
          isEdit ? 'Edit Book' : 'Form Book',
          style: AppTypography.title.copyWith(
            color: ColorStyle.neutral1,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: ColorStyle.neutral3,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: ColorStyle.neutral1,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Form Fields
            TextFieldOutlined(
              controller: controller.nameController,
              labelText: "Items Name...",
            ),
            const SizedBox(height: 20),

            TextFieldOutlined(
              controller: controller.categoryController,
              labelText: "Category...",
            ),
            const SizedBox(height: 20),

            _buildLabel("Stock amount"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: ColorStyle.neutral3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => controller.decrementStock(),
                    icon: const Icon(Icons.remove_circle_outline),
                    color: ColorStyle.neutral1,
                  ),
                  Obx(
                    () => Text(
                      "${controller.stockCount.value}",
                      style: AppTypography.title.copyWith(
                        color: ColorStyle.neutral2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.incrementStock(),
                    icon: const Icon(Icons.add_circle_outline),
                    color: ColorStyle.neutral1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Obx(
              () => PrimaryBtn(
                text: controller.isLoading.value
                    ? "Loading..."
                    : (isEdit ? "Update" : "Submit"),
                height: 55,
                borderRadius: 20,
                onPressed: () => controller.submitForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: AppTypography.title.copyWith(color: ColorStyle.neutral1),
      ),
    );
  }
}
