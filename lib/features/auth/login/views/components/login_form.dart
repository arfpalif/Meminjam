import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import '../../controllers/login_controller.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorStyle.neutral1,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: controller.emailController,
            onChanged: (value) => controller.isFormValid.value,
            decoration: InputDecoration(
              hintText: 'youremail@mail.com',
              hintStyle: const TextStyle(color: Color(0xFFCBD5E1)),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: ColorStyle.neutral1,
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
                      ? ColorStyle.neutral3
                      : Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: controller.emailError.value.isEmpty
                      ? ColorStyle.primary
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
        Text(
          'Password',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorStyle.neutral1,
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
              prefixIcon: Icon(Icons.lock_outline, color: ColorStyle.neutral1),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off_outlined,
                  color: ColorStyle.neutral1,
                ),
                onPressed: controller.togglePasswordVisibility,
              ),
              filled: true,
              fillColor: Colors.white,
              errorText: controller.passwordError.value.isEmpty
                  ? null
                  : controller.passwordError.value,
              errorStyle: const TextStyle(color: ColorStyle.error),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: controller.passwordError.value.isEmpty
                      ? ColorStyle.neutral3
                      : ColorStyle.error,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: controller.passwordError.value.isEmpty
                      ? ColorStyle.primary
                      : ColorStyle.error,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: ColorStyle.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: ColorStyle.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
