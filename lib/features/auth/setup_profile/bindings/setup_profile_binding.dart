import 'package:get/get.dart';
import '../controllers/setup_profile_controller.dart';
import '../repositories/profile_repository.dart';

class SetupProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileRepository());
    Get.put(SetupProfileController());
  }
}
