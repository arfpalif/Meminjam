import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final isAuthenticated = false.obs;
  final isLoading = true.obs;
  final currentUser = Rxn<User>();
  final errorMessage = Rxn<String>();
  final storage = FlutterSecureStorage();

  late final SupabaseClient _supabaseClient;

  @override
  void onInit() {
    super.onInit();
    _supabaseClient = Supabase.instance.client;
  }

  Future<bool> logout() async {
    try {
      isLoading.value = true;
      await _supabaseClient.auth.signOut();
      await storage.delete(key: 'token');
      debugPrint("token deleted ${await storage.read(key: 'token')}");
      await storage.delete(key: 'user');
      debugPrint("user deleted ${await storage.read(key: 'user')}");
      isAuthenticated.value = false;
      currentUser.value = null;
      Get.offAllNamed(Routes.LOGIN);
      return true;
    } catch (e) {
      errorMessage.value = 'Failed to logout';

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  String? get userEmail => currentUser.value?.email;

  bool get isLoggedIn => isAuthenticated.value;

  void clearError() {
    errorMessage.value = null;
  }
}
