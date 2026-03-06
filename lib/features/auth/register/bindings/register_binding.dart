import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../repositories/register_repository.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterRepository>(() => RegisterRepository());
    Get.put<RegisterController>(RegisterController());
  }
}
