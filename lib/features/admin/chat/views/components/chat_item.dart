import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class ChatItem extends StatelessWidget {
  final Map<String, dynamic> chat;

  const ChatItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.toNamed(Routes.CHAT_ROOM, arguments: chat['id']),
      leading: CircleAvatar(
        backgroundColor: ColorStyle.primary.withOpacity(0.1),
        child: Icon(Icons.person_outline, color: ColorStyle.primary),
      ),
      title: Text(
        "Chat Room",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "ID: ${chat['id'].toString().substring(0, 8)}...",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
    );
  }
}
