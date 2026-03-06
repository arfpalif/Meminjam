import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/features/admin/history/controllers/activity_controller.dart';
import 'package:meminjam/features/admin/history/models/activity_model.dart';
import 'package:intl/intl.dart';
import 'package:meminjam/shared/widgets/state_widgets.dart';
import 'home_activity_item.dart';

class HomeRecentActivity extends StatelessWidget {
  const HomeRecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActivityController());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Activity Logs", style: AppTypography.h3),
            TextButton(
              onPressed: () => controller.fetchLogs(),
              child: Text("Refresh", style: AppTypography.subtitle),
            ),
          ],
        ),
        Obx(() {
          if (controller.isLoading.value && controller.logs.isEmpty) {
            return const LoadingWidget();
          }

          if (controller.logs.isEmpty) {
            return const EmptyStateWidget(
              title: "No Activity",
              message: "Recent activity logs will appear here.",
              icon: Icons.history_rounded,
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.logs.length,
            itemBuilder: (context, index) {
              final log = controller.logs[index];
              return Column(
                children: [
                  _buildActivityItem(log),
                  if (index != controller.logs.length - 1) const Divider(),
                ],
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildActivityItem(ActivityModel log) {
    String title = "";
    String desc = "";
    IconData icon = Icons.info_outline;

    switch (log.action) {
      case 'ADD_ITEM':
        title = "Item Added Successfully ! 🤩";
        desc =
            "You have successfully added the ${log.details['category'] ?? 'item'} ${log.details['item_name']} to your library!";
        icon = Icons.book;
        break;
      case 'BORROW_ITEM':
        title = "Someone Borrow a Book!";
        desc =
            "${log.details['borrower_name']} borrowed the ${log.details['item_name']}. click here for details";
        icon = Icons.campaign;
        break;
      case 'RETURN_ITEM':
        title = "Book Returned!";
        desc =
            "${log.details['borrower_name']} returned the ${log.details['item_name']}.";
        icon = Icons.assignment_return_rounded;
        break;
      default:
        title = "System Update";
        desc = "Action ${log.action} was performed.";
    }

    final dateStr = DateFormat('dd MMM').format(log.createdAt);
    final timeStr = DateFormat('HH.mm').format(log.createdAt);

    return HomeActivityItem(
      title: title,
      desc: desc,
      date: dateStr,
      time: timeStr,
      icon: icon,
    );
  }
}
