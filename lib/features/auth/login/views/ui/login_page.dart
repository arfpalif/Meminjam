import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/shared/widgets/buttons/deactive_btn.dart';
import 'package:meminjam/shared/widgets/buttons/primary_btn.dart';
import '../../controllers/login_controller.dart';
import '../components/login_form.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('src/images/logo.png', width: 60, height: 60),
                    const SizedBox(width: 12),
                    Text(
                      'Meminjam',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorStyle.neutral1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.neutral1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You can log into your account first to read many interesting books!',
                style: TextStyle(fontSize: 16, color: ColorStyle.neutral2),
              ),
              const SizedBox(height: 32),
              const LoginForm(),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text.rich(
                    TextSpan(
                      text: 'Forgot your password? ',
                      style: TextStyle(color: ColorStyle.neutral2),
                      children: [
                        TextSpan(
                          text: 'Reset here',
                          style: TextStyle(
                            color: ColorStyle.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => controller.isFormValid.value
                    ? PrimaryBtn(
                        text: "Login",
                        onPressed: controller.login,
                        borderRadius: 28,
                        height: 56,
                      )
                    : DeactiveBtn(
                        text: "Login",
                        onPressed: () {},
                        borderRadius: 28,
                        height: 56,
                      ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'src/images/ic_google.svg',
                    height: 24,
                  ),
                  label: Text(
                    'Login with Google',
                    style: TextStyle(
                      color: ColorStyle.neutral1,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ColorStyle.neutral3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(Routes.REGISTER),
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: ColorStyle.neutral1),
                      children: [
                        TextSpan(
                          text: 'Register here',
                          style: TextStyle(
                            color: ColorStyle.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
