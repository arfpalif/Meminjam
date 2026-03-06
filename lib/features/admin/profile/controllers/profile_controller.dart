import 'package:get/get.dart';
import '../../../auth/setup_profile/models/profile_model.dart';
import '../repositories/profile_repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository = Get.find<ProfileRepository>();

  final userProfile = Rxn<ProfileModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final profile = await _repository.getProfile();
      userProfile.value = profile;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch profile');
    } finally {
      isLoading.value = false;
    }
  }
}
