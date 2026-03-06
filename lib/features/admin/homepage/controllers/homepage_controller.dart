import 'package:get/get.dart';

import '../../../auth/login/repositories/login_repository.dart';
import '../repositories/home_repository.dart';
import '../../../auth/setup_profile/models/profile_model.dart';

class HomepageController extends GetxController {
  final LoginRepository _loginRepository = Get.find<LoginRepository>();
  final HomeRepository _homeRepository = Get.find<HomeRepository>();

  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  final userProfile = Rxn<ProfileModel>();
  final isLoading = false.obs;

  final totalItems = 0.obs;
  final availableItems = 0.obs;
  final borrowedItems = 0.obs;
  final borrowRequests = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
    fetchStats();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    try {
      final profile = await _loginRepository.getProfile();
      userProfile.value = profile;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user profile');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStats() async {
    try {
      final response = await _homeRepository.getItems();
      final items = response.data as List;
      totalItems.value = items.length;
      availableItems.value = items
          .where((item) => item['available_stock'] > 0)
          .length;

      borrowedItems.value = items.fold(
        0,
        (sum, item) =>
            sum + ((item['total_stock'] ?? 0) - (item['available_stock'] ?? 0))
                as int,
      );
    } catch (e) {
      print("Error fetching stats: $e");
    }
  }

  void changePage(int index) {
    _currentIndex.value = index;
  }
}
