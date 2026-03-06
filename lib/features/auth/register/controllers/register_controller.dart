import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repositories/register_repository.dart';
import '../../../../configs/routes/route.dart';

class RegisterController extends GetxController {
  final RegisterRepository _repository = Get.find<RegisterRepository>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailError = ''.obs;
  final passwordError = ''.obs;
  final confirmPasswordError = ''.obs;
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  RxBool isFormValid = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> register() async {
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';

    bool hasError = false;
    if (emailController.text.isEmpty) {
      emailError.value = 'Email is required';
      hasError = true;
    }
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      hasError = true;
    }
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = 'Confirm password is required';
      hasError = true;
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      hasError = true;
    }

    if (hasError) return;

    isLoading.value = true;
    try {
      final response = await _repository.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final userId = data['user']['id'];
        final accessToken = data['access_token'];

        Get.offAllNamed(
          Routes.SETUP_PROFILE,
          arguments: {
            'email': emailController.text.trim(),
            'userId': userId,
            'token': accessToken,
          },
        );
      } else {
        Get.snackbar('Error', 'Registration failed: ${response.statusMessage}');
      }
    } catch (e) {
      if (e is DioException) {
        Get.snackbar("Error", e.message ?? "Network error during signup");
      } else {
        Get.snackbar('Error', 'An error occurred: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void validateForm() {
    isFormValid.value =
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
