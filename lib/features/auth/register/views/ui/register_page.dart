import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/shared/widgets/buttons/deactive_btn.dart';
import 'package:meminjam/shared/widgets/buttons/primary_btn.dart';
import '../../controllers/register_controller.dart';
import '../components/register_form.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorStyle.neutral1),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ColorStyle.primary,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Baca',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorStyle.neutral1,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.neutral1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create a new account so you can read lots of interesting books!',
                style: TextStyle(fontSize: 16, color: ColorStyle.neutral2),
              ),
              const SizedBox(height: 32),
              const RegisterForm(),
              const SizedBox(height: 32),
              Obx(
                () => controller.isFormValid.value
                    ? PrimaryBtn(
                        text: "Sign up",
                        onPressed: controller.register,
                        borderRadius: 28,
                        height: 56,
                      )
                    : DeactiveBtn(
                        text: "Sign up",
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
                    'Register with Google',
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
                child: Column(
                  children: [
                    Text(
                      'By continuing, you agree to our Terms of Service.',
                      style: TextStyle(
                        color: ColorStyle.neutral2,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        text: 'Read our ',
                        style: TextStyle(
                          color: ColorStyle.neutral2,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: ColorStyle.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
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
