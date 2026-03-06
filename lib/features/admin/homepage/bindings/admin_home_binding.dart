import 'package:get/get.dart';
import 'package:meminjam/features/admin/homepage/controllers/homepage_controller.dart';
import 'package:meminjam/features/admin/homepage/repositories/home_repository.dart';
import 'package:meminjam/features/admin/profile/controllers/profile_controller.dart';
import 'package:meminjam/features/admin/profile/repositories/profile_repository.dart';
import 'package:meminjam/features/admin/setting/controllers/setting_controller.dart';
import 'package:meminjam/features/admin/stock/controllers/stock_controller.dart';
import 'package:meminjam/features/admin/stock/repositories/stock_repository.dart';
import 'package:meminjam/features/admin/chat/repositories/chat_repository.dart';
import 'package:meminjam/features/admin/history/repositories/activity_repository.dart';
import 'package:meminjam/features/auth/login/repositories/login_repository.dart';
import 'package:meminjam/shared/controllers/auth_controller.dart';

class AdminHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeRepository());
    Get.lazyPut(() => HomepageController());
    Get.lazyPut(() => StockRepository());
    Get.lazyPut(() => ActivityRepository());
    Get.lazyPut(() => ChatRepository());
    Get.lazyPut(() => StockController());
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => LoginRepository());
    Get.lazyPut(() => ProfileRepository());
    Get.lazyPut(() => ProfileController());
  }
}
