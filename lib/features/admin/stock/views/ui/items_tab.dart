import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/features/admin/stock/controllers/stock_controller.dart';
import 'package:meminjam/features/admin/stock/views/components/filter_chips.dart';
import 'package:meminjam/features/admin/stock/views/components/stock_item_card.dart';
import 'package:meminjam/shared/widgets/state_widgets.dart';

class ItemsTab extends GetView<StockController> {
  const ItemsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFilterChips(controller),
            const SizedBox(height: 20),
            if (controller.items.isEmpty)
              const EmptyStateWidget(
                title: 'No items found',
                message: 'Start by adding some items to your inventory.',
                icon: Icons.inventory_2_outlined,
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return StockItemCard(item: controller.items[index]);
                },
              ),
          ],
        ),
      ),
    );
  }
}
