import 'package:get/get.dart';
import 'package:meminjam/features/admin/chat/controllers/chat_controller.dart';
import 'package:meminjam/features/admin/chat/controllers/chat_list_controller.dart';
import 'package:meminjam/features/admin/chat/repositories/chat_repository.dart';
import 'package:meminjam/features/admin/stock/repositories/stock_repository.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => ChatListController());
    Get.lazyPut(() => ChatRepository());
    Get.lazyPut(() => StockRepository());
  }
}
