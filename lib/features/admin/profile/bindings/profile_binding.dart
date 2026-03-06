import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../repositories/profile_repository.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileRepository());
    Get.put(ProfileController());
  }
}
