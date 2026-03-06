import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repositories/profile_repository.dart';
import '../models/profile_model.dart';
import '../views/components/success_bottom_sheet.dart';

class SetupProfileController extends GetxController {
  final ProfileRepository _repository = Get.find<ProfileRepository>();

  final fullNameController = TextEditingController();
  final selectedGender = 'Male'.obs;
  final email = ''.obs;
  final userId = ''.obs;
  final token = ''.obs;
  final isLoading = false.obs;

  final List<String> genders = ['Male', 'Female'];
  final isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      email.value = args['email'] ?? '';
      userId.value = args['userId'] ?? '';
      token.value = args['token'] ?? '';
    }
  }

  void onChangeGender(String? value) {
    if (value != null) {
      selectedGender.value = value;
      validateForm();
    }
  }

  void validateForm() {
    isFormValid.value =
        fullNameController.text.trim().isNotEmpty &&
        selectedGender.value.isNotEmpty;
  }

  void showPhotoComingSoon() {
    Get.snackbar(
      'Coming Soon',
      'Profile photo upload feature is coming soon!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }

  Future<void> submitProfile() async {
    if (!isFormValid.value) return;

    isLoading.value = true;
    try {
      final profile = ProfileModel(
        id: userId.value,
        email: email.value,
        name: fullNameController.text.trim(),
        gender: selectedGender.value,
      );

      final tokenValue = token.value;
      if (tokenValue.isEmpty) {
        throw "Access token is missing. Please try to register again.";
      }

      final response = await _repository.createProfile(profile, tokenValue);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.bottomSheet(
          SuccessBottomSheet(
            name: fullNameController.text.trim(),
            message: 'Your account successfully created!',
            subMessage:
                'Your account has successfully created. You can go to login page first to login into your account!',
          ),
          isDismissible: false,
          enableDrag: false,
        );
      } else {
        debugPrint('Failed to save profile: ${response.statusMessage}');
        Get.snackbar(
          'Error',
          'Failed to save profile: ${response.statusMessage}',
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    super.onClose();
  }
}
