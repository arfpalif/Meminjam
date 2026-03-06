import 'package:get/get.dart';
import '../../utils/services/network_service.dart';
import '../../utils/services/notification_service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkService>(NetworkService(), permanent: true);
    Get.put<NotificationService>(NotificationService(), permanent: true);
  }
}
