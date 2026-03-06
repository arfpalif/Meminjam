import 'package:get/get.dart';
import 'package:meminjam/features/admin/chat/repositories/chat_repository.dart';

class ChatListController extends GetxController {
  final ChatRepository _chatRepository = ChatRepository();

  final chats = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  Future<void> fetchChats() async {
    try {
      isLoading(true);
      final list = await _chatRepository.getChats();
      chats.assignAll(list);
    } finally {
      isLoading(false);
    }
  }
}
