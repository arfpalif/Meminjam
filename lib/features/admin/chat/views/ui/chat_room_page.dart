import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chat_controller.dart';
import '../components/chat_bubble.dart';
import '../components/chat_input.dart';

class ChatRoomPage extends GetView<ChatController> {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat items'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Obx(() {
            final item = controller.itemDetail.value;
            if (item == null) return const SizedBox.shrink();

            return Container(
              color: Colors.white,
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.inventory_2_outlined),
                ),
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item.category),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Stok', style: TextStyle(fontSize: 12)),
                    Text(
                      '${item.availableStock}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const Divider(height: 1),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.messages.isEmpty) {
                return const Center(
                  child: Text('Belum ada pesan. Mulai obrolan!'),
                );
              }

              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return ChatBubble(
                    message: message,
                    currentUserId: controller.currentUserId.value,
                  );
                },
              );
            }),
          ),
          ChatInput(onSend: (content) => controller.sendMessage(content)),
        ],
      ),
    );
  }
}
