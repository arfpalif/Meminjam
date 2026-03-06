import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meminjam/features/admin/chat/repositories/chat_repository.dart';
import 'package:meminjam/features/admin/stock/repositories/stock_repository.dart';
import 'package:meminjam/features/admin/stock/models/stock_model.dart';
import '../models/chat_message_model.dart';

class ChatController extends GetxController {
  final ChatRepository _chatRepository = Get.find<ChatRepository>();
  final StockRepository _stockRepository = Get.find<StockRepository>();

  final messages = <ChatMessageModel>[].obs;
  final isLoading = true.obs;
  final currentUserId = ''.obs;
  final Rxn<StockModel> itemDetail = Rxn<StockModel>();

  final String? chatId = Get.arguments is String ? Get.arguments : null;

  @override
  void onInit() {
    super.onInit();
    if (chatId != null) {
      _initChat();
    } else {
      isLoading(false);
      debugPrint("Warning: ChatId tidak valid atau tidak ditemukan");
    }
  }

  Future<void> _initChat() async {
    try {
      final userId = await _chatRepository.storage.read(key: 'user_id');
      currentUserId.value = userId ?? '';

      final chatData = await _chatRepository.getChatById(chatId!);
      final itemId = chatData['item_id'];

      if (itemId != null) {
        fetchItemDetail(itemId);
      }

      await fetchMessages();
      setupSubscription();
    } catch (e) {
      isLoading(false);
      debugPrint("Error initializing chat room: $e");
    }
  }

  Future<void> fetchItemDetail(String itemId) async {
    try {
      final item = await _stockRepository.getItemById(itemId);
      itemDetail.value = item;
    } catch (e) {
      debugPrint("Error fetching item detail: $e");
    }
  }

  void setupSubscription() {
    _chatRepository.subscribeToMessages(
      chatId: chatId!,
      onNewMessage: (newMessage) {
        if (!messages.any((m) => m.id == newMessage.id)) {
          messages.insert(0, newMessage);
        }
      },
    );
  }

  Future<void> fetchMessages() async {
    try {
      isLoading(true);
      final list = await _chatRepository.getMessages(chatId!);
      messages.assignAll(list);
    } finally {
      isLoading(false);
    }
  }

  void sendMessage(String content) async {
    if (content.isEmpty) return;
    if (chatId == null) {
      Get.snackbar('Error', 'ID Chat tidak valid');
      return;
    }

    try {
      await _chatRepository.sendMessage(chatId: chatId!, message: content);
    } catch (e) {
      debugPrint("gagal mengirim pesan $e");
      Get.snackbar('Error', 'Gagal mengirim pesan');
    }
  }
}
