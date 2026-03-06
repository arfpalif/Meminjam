import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/features/admin/stock/controllers/stock_controller.dart';
import 'package:meminjam/features/admin/stock/views/components/loan_card.dart';
import 'package:meminjam/shared/widgets/state_widgets.dart';

class TransactionsTab extends GetView<StockController> {
  const TransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: controller.fetchLoans,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              if (controller.loans.isEmpty)
                const EmptyStateWidget(
                  title: 'No transactions found',
                  message: 'Your loan history will appear here.',
                  icon: Icons.history_rounded,
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.loans.length,
                  itemBuilder: (context, index) {
                    final loan = controller.loans[index];
                    return LoanCard(
                      loan: loan,
                      itemName: controller.getItemName(loan.itemId),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
