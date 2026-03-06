import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import 'package:meminjam/features/admin/stock/views/ui/items_tab.dart';
import 'package:meminjam/features/admin/stock/views/ui/transactions_tab.dart';
import '../../controllers/stock_controller.dart';
import '../components/stock_header.dart';
import '../components/stock_tab_bar.dart';
import 'package:meminjam/shared/widgets/state_widgets.dart';

class AdminStockPage extends StatelessWidget {
  const AdminStockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StockController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: [
            StockHeader(),
            const StockTabBar(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const LoadingWidget(message: 'Loading inventory...');
                }

                if (controller.currentTab.value == 1) {
                  return TransactionsTab();
                }

                return ItemsTab();
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CHAT_LIST),
        backgroundColor: const Color(0xFF643FDB),
        child: const Icon(
          Icons.chat_bubble_outline_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
