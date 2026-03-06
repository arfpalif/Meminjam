import 'package:get/get.dart';
import '../controllers/notification_controller.dart';
import '../repositories/notification_repository.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationRepository>(() => NotificationRepository());
    Get.put<NotificationController>(NotificationController());
  }
}
