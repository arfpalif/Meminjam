import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/stock/controllers/stock_controller.dart';
import 'package:meminjam/features/admin/stock/models/loan_model.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/shared/widgets/buttons/primary_btn.dart';

class LoanDetailPage extends GetView<StockController> {
  const LoanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoanModel loan = Get.arguments;
    final dateFormat = DateFormat('dd/MM/yyyy');
    final itemName = controller.getItemName(loan.itemId);

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
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: ColorStyle.neutral3.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Icon(
                      loan.isActive
                          ? Icons.arrow_outward
                          : Icons.check_circle_outline,
                      size: 120,
                      color: loan.isOverdue
                          ? ColorStyle.error
                          : ColorStyle.primary,
                    ),
                  ),
                ),
                Positioned(top: 20, right: 40, child: _buildStatusBadge(loan)),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(loan.borrowerName, style: AppTypography.h1),
                  const SizedBox(height: 8),
                  Text(
                    itemName,
                    style: AppTypography.subtitle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Container(height: 1, color: ColorStyle.neutral3),
                  const SizedBox(height: 20),
                  _buildDetailRow(
                    "Loan date",
                    dateFormat.format(loan.loanDate),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow("Due date", dateFormat.format(loan.dueDate)),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    "Return date",
                    loan.returnDate != null
                        ? dateFormat.format(loan.returnDate!)
                        : "Belum dikembalikan",
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: loan.isActive
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => PrimaryBtn(
                  text: controller.isLoading.value
                      ? "Loading..."
                      : "Return Item",
                  height: 55,
                  borderRadius: 20,
                  onPressed: () => controller.returnItem(loan.id),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildStatusBadge(LoanModel loan) {
    Color bgColor;
    Color textColor;
    String label;

    if (loan.isOverdue) {
      bgColor = ColorStyle.error;
      textColor = Colors.white;
      label = "Overdue";
    } else if (loan.isActive) {
      bgColor = ColorStyle.primary;
      textColor = Colors.white;
      label = "Active";
    } else {
      bgColor = Colors.green;
      textColor = Colors.white;
      label = "Returned";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
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
