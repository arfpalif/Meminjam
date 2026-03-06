import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/stock/controllers/stock_controller.dart';
import 'package:meminjam/features/admin/stock/models/stock_model.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/shared/widgets/buttons/primary_btn.dart';
import 'package:meminjam/shared/widgets/textfields/outline_textfields.dart';

class LoanFormPage extends GetView<StockController> {
  const LoanFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyle.neutral1),
          onPressed: () {
            controller.clearLoanForm();
            Get.back();
          },
        ),
        title: Text(
          'Loan form',
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
            // Choose Item
            _buildLabel("Choose item"),
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorStyle.neutral3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<StockModel>(
                    isExpanded: true,
                    hint: Text(
                      "Choose item...",
                      style: AppTypography.subtitle.copyWith(
                        color: ColorStyle.neutral2,
                      ),
                    ),
                    value: controller.selectedItem.value,
                    items: controller.items.map((item) {
                      return DropdownMenuItem<StockModel>(
                        value: item,
                        child: Text(
                          item.name,
                          style: AppTypography.subtitle.copyWith(
                            color: ColorStyle.neutral1,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedItem.value = value;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Borrower Name
            _buildLabel("Borrower name"),
            TextFieldOutlined(
              controller: controller.borrowerNameController,
              labelText: "Borrower name",
            ),
            const SizedBox(height: 20),

            // Loan Date
            _buildLabel("Loan date"),
            Obx(
              () => GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: controller.loanDate.value ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    controller.loanDate.value = picked;
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorStyle.neutral3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    controller.loanDate.value != null
                        ? dateFormat.format(controller.loanDate.value!)
                        : "Select date...",
                    style: AppTypography.subtitle.copyWith(
                      color: controller.loanDate.value != null
                          ? ColorStyle.neutral1
                          : ColorStyle.neutral2,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Return Date (Due Date)
            _buildLabel("Return date"),
            Obx(
              () => GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate:
                        controller.dueDate.value ??
                        (controller.loanDate.value ?? DateTime.now()).add(
                          const Duration(days: 7),
                        ),
                    firstDate: controller.loanDate.value ?? DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    controller.dueDate.value = picked;
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorStyle.neutral3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    controller.dueDate.value != null
                        ? dateFormat.format(controller.dueDate.value!)
                        : "Select date...",
                    style: AppTypography.subtitle.copyWith(
                      color: controller.dueDate.value != null
                          ? ColorStyle.neutral1
                          : ColorStyle.neutral2,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Obx(() {
              if (controller.isCheckingStock.value) {
                return Row(
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Mengecek ketersediaan stok...',
                      style: AppTypography.caption.copyWith(
                        color: ColorStyle.neutral2,
                      ),
                    ),
                  ],
                );
              }

              final stock = controller.availableStockForDates.value;
              if (stock == null) return const SizedBox.shrink();

              final totalStock = controller.selectedItem.value?.totalStock ?? 0;
              final isAvailable = stock > 0;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isAvailable ? Colors.green : Colors.red,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isAvailable
                          ? Icons.check_circle_outline
                          : Icons.cancel_outlined,
                      color: isAvailable ? Colors.green : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        isAvailable
                            ? 'Stok tersedia: $stock dari $totalStock unit'
                            : 'Stok penuh untuk rentang tanggal ini',
                        style: AppTypography.subtitle.copyWith(
                          color: isAvailable ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          final stock = controller.availableStockForDates.value;
          final isDisabled = stock != null && stock <= 0;
          final isChecking = controller.isCheckingStock.value;

          return Opacity(
            opacity: (isDisabled || isChecking) ? 0.5 : 1.0,
            child: IgnorePointer(
              ignoring: isDisabled || isChecking,
              child: PrimaryBtn(
                text: controller.isLoading.value ? "Loading..." : "Submit",
                height: 55,
                borderRadius: 20,
                onPressed: () => controller.submitLoan(),
              ),
            ),
          );
        }),
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
