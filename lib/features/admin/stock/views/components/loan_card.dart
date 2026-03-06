import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/stock/models/loan_model.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:intl/intl.dart';

class LoanCard extends StatelessWidget {
  final LoanModel loan;
  final String itemName;

  const LoanCard({super.key, required this.loan, required this.itemName});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child!),
        );
      },
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.LOAN_DETAIL, arguments: loan),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorStyle.neutral3),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: loan.isOverdue
                      ? ColorStyle.error.withValues(alpha: 0.1)
                      : ColorStyle.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  loan.isActive
                      ? Icons.arrow_outward
                      : Icons.check_circle_outline,
                  color: loan.isOverdue ? ColorStyle.error : ColorStyle.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loan.borrowerName, style: AppTypography.title),
                    const SizedBox(height: 4),
                    Text(itemName, style: AppTypography.subtitle),
                    const SizedBox(height: 8),
                    Text(
                      "${dateFormat.format(loan.loanDate)} — ${dateFormat.format(loan.dueDate)}",
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: loan.isOverdue
                      ? ColorStyle.error.withValues(alpha: 0.1)
                      : loan.isActive
                      ? ColorStyle.primary.withValues(alpha: 0.1)
                      : Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  loan.isOverdue
                      ? "Overdue"
                      : loan.isActive
                      ? "Active"
                      : "Returned",
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: loan.isOverdue
                        ? ColorStyle.error
                        : loan.isActive
                        ? ColorStyle.primary
                        : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
