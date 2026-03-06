import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/register_controller.dart';

class RegisterForm extends GetView<RegisterController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: controller.emailController,
            onChanged: (value) => controller.validateForm(),
            decoration: InputDecoration(
              hintText: 'youremail@mail.com',
              hintStyle: const TextStyle(color: Color(0xFFCBD5E1)),
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Color(0xFF1E293B),
              ),
              filled: true,
              fillColor: Colors.white,
              errorText: controller.emailError.value.isEmpty
                  ? null
                  : controller.emailError.value,
              errorStyle: const TextStyle(color: Colors.red),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: controller.emailError.value.isEmpty
                      ? const Color(0xFFE2E8F0)
                      : Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: controller.emailError.value.isEmpty
                      ? const Color(0xFF6366F1)
                      : Colors.red,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: controller.passwordController,
            onChanged: (value) => controller.validateForm(),
            obscureText: !controller.isPasswordVisible.value,
            decoration: InputDecoration(
              hintText: 'Input your password',
              hintStyle: const TextStyle(color: Color(0xFFCBD5E1)),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF1E293B),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off_outlined,
                  color: const Color(0xFF1E293B),
                ),
                onPressed: controller.togglePasswordVisibility,
              ),
              filled: true,
              fillColor: Colors.white,
              errorText: controller.passwordError.value.isEmpty
                  ? null
                  : controller.passwordError.value,
              errorStyle: const TextStyle(color: Color(0xFFFF6A5D)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: controller.passwordError.value.isEmpty
                      ? const Color(0xFFE2E8F0)
                      : const Color(0xFFFF6A5D),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: controller.passwordError.value.isEmpty
                      ? const Color(0xFF6366F1)
                      : const Color(0xFFFF6A5D),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFFF6A5D)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFFF6A5D)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Confirm password',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: controller.confirmPasswordController,
            onChanged: (value) => controller.validateForm(),
            obscureText: !controller.isConfirmPasswordVisible.value,
            decoration: InputDecoration(
              hintText: 'Input your password again',
              hintStyle: const TextStyle(color: Color(0xFFCBD5E1)),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF1E293B),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isConfirmPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off_outlined,
                  color: const Color(0xFF1E293B),
                ),
                onPressed: controller.toggleConfirmPasswordVisibility,
              ),
              filled: true,
              fillColor: Colors.white,
              errorText: controller.confirmPasswordError.value.isEmpty
                  ? null
                  : controller.confirmPasswordError.value,
              errorStyle: const TextStyle(color: Color(0xFFFF6A5D)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: controller.confirmPasswordError.value.isEmpty
                      ? const Color(0xFFE2E8F0)
                      : const Color(0xFFFF6A5D),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: controller.confirmPasswordError.value.isEmpty
                      ? const Color(0xFF6366F1)
                      : const Color(0xFFFF6A5D),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFFF6A5D)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFFF6A5D)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
