import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../repositories/splash_repository.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashRepository>(() => SplashRepository());
    Get.put<SplashController>(SplashController());
  }
}
