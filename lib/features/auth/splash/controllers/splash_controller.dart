import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import '../repositories/splash_repository.dart';

class SplashController extends GetxController {
  final SplashRepository _repository = Get.find<SplashRepository>();

  @override
  void onReady() {
    super.onReady();
    _checkSession();
    debugPrint("ini on Ready session ");
  }

  Future<void> _checkSession() async {
    // Wait for 2 seconds to ensure logo is seen and navigator is ready
    await Future.delayed(const Duration(seconds: 2));
    debugPrint("checking session ");

    try {
      final session = _repository.getSession();
      debugPrint("ini get session");

      if (session != null) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.ONBOARDING);
      }
    } catch (e) {
      // In case of error, default to onboarding
      Get.offAllNamed(Routes.ONBOARDING);
    }
  }
}
