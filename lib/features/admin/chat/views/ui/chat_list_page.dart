import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chat_list_controller.dart';
import 'package:meminjam/shared/widgets/state_widgets.dart';
import '../components/chat_item.dart';

class ChatListPage extends GetView<ChatListController> {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Chat'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        if (controller.chats.isEmpty) {
          return const EmptyStateWidget(
            title: "No Chats",
            message: "Start a conversation to see your messages here.",
            icon: Icons.chat_bubble_outline_rounded,
          );
        }

        return ListView.separated(
          itemCount: controller.chats.length,
          separatorBuilder: (context, index) => const Divider(height: 2),
          itemBuilder: (context, index) {
            return ChatItem(chat: controller.chats[index]);
          },
        );
      }),
    );
  }
}
