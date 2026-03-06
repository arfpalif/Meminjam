import 'package:get/get.dart';
import 'package:meminjam/features/admin/analytics/bindings/analytics_binding.dart';
import 'package:meminjam/features/admin/analytics/views/ui/analytics_page.dart';
import 'package:meminjam/features/admin/homepage/bindings/admin_home_binding.dart';
import 'package:meminjam/features/admin/setting/bindings/setting_binding.dart';
import 'package:meminjam/features/admin/setting/views/ui/admin_setting_page.dart';
import 'package:meminjam/features/admin/chat/bindings/chat_binding.dart';
import 'package:meminjam/features/admin/chat/views/ui/chat_list_page.dart';
import 'package:meminjam/features/admin/chat/views/ui/chat_room_page.dart';
import 'package:meminjam/features/admin/stock/bindings/stock_binding.dart';
import 'package:meminjam/features/admin/stock/views/ui/admin_stock_page.dart';
import 'package:meminjam/features/admin/stock/views/ui/item_add_page.dart';
import 'package:meminjam/features/admin/stock/views/ui/item_detail.dart';
import 'package:meminjam/features/admin/stock/views/ui/loan_detail_page.dart';
import 'package:meminjam/features/admin/stock/views/ui/loan_form_page.dart';
import 'package:meminjam/features/auth/onboarding/ui/onboarding_page.dart';
import 'package:meminjam/shared/widgets/admin_bottom_nav.dart';
import '../../features/auth/login/bindings/login_binding.dart';
import '../../features/auth/login/views/ui/login_page.dart';
import '../../features/auth/register/bindings/register_binding.dart';
import '../../features/auth/register/views/ui/register_page.dart';
import '../../features/auth/setup_profile/bindings/setup_profile_binding.dart';
import '../../features/auth/setup_profile/views/ui/setup_profile_page.dart';
import '../../features/auth/splash/bindings/splash_binding.dart';
import '../../features/auth/splash/views/ui/splash_page.dart';
import '../routes/route.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.ONBOARDING, page: () => const OnboardingPage()),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.SETUP_PROFILE,
      page: () => const SetupProfilePage(),
      binding: SetupProfileBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => AdminBottomNav(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: Routes.ADMIN_STOCK,
      page: () => const AdminStockPage(),
      binding: StockBinding(),
    ),
    GetPage(
      name: Routes.ADMIN_SETTINGS,
      page: () => AdminSettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.STOCK_ADD,
      page: () => const ItemAddPage(),
      binding: StockBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.ITEM_DETAIL,
      page: () => const ItemDetailPage(),
      binding: StockBinding(),
    ),
    GetPage(
      name: Routes.LOAN_FORM,
      page: () => const LoanFormPage(),
      binding: StockBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.LOAN_DETAIL,
      page: () => const LoanDetailPage(),
      binding: StockBinding(),
    ),
    GetPage(
      name: Routes.CHAT_LIST,
      page: () => const ChatListPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.CHAT_ROOM,
      page: () => const ChatRoomPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.ANALYTICS,
      page: () => const AnalyticsPage(),
      binding: AnalyticsBinding(),
    ),
  ];
}
