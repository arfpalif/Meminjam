import 'package:get/get.dart';
import '../controllers/stock_controller.dart';
import '../repositories/stock_repository.dart';
import '../../history/repositories/activity_repository.dart';
import '../../chat/repositories/chat_repository.dart';

class StockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockRepository>(() => StockRepository());
    Get.lazyPut<ActivityRepository>(() => ActivityRepository());
    Get.lazyPut<ChatRepository>(() => ChatRepository());
    Get.put<StockController>(StockController());
  }
}
