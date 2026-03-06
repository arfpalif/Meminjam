import 'package:get/get.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class FailedSnackbar {
  static void show(String message) {
    Get.snackbar(
      'Failed',
      message,
      backgroundColor: ColorStyle.error,
      colorText: ColorStyle.neutral4,
      snackPosition: SnackPosition.TOP,
    );
  }
}
