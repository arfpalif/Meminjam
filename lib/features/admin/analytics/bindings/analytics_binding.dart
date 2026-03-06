import 'package:get/get.dart';
import '../controllers/analytics_controller.dart';
import '../repositories/analytics_repository.dart';

class AnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnalyticsRepository());
    Get.lazyPut(() => AnalyticsController());
  }
}
