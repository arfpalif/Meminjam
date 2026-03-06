import 'package:get/get.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class SuccessSnackbar {
  static void show(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: ColorStyle.success,
      colorText: ColorStyle.neutral1,
      snackPosition: SnackPosition.TOP,
    );
  }
}
