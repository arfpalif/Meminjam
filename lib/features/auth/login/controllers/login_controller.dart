import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import '../repositories/login_repository.dart';
import '../../../../configs/routes/route.dart';

class LoginController extends GetxController {
  final LoginRepository _repository = Get.find<LoginRepository>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailError = ''.obs;
  final passwordError = ''.obs;
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  RxBool isFormValid = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    emailError.value = '';
    passwordError.value = '';

    bool hasError = false;
    if (emailController.text.isEmpty) {
      emailError.value = 'Email is required';
      hasError = true;
    }
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      hasError = true;
    }

    if (hasError) return;

    isLoading.value = true;
    try {
      final response = await _repository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Sync session to Supabase Client for RLS
      await Supabase.instance.client.auth.recoverSession(
        jsonEncode(response.data),
      );

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data['error_description'] ?? e.message;
        if (message.toString().toLowerCase().contains(
          'invalid login credentials',
        )) {
          passwordError.value = 'Invalid email or password';
        } else {
          Get.snackbar('Error', message.toString());
        }
      } else {
        debugPrint(e.toString());
        Get.snackbar('Error', 'An error occurred: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void validateForm() {
    isFormValid.value =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
