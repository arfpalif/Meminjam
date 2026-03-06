import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/shared/widgets/buttons/primary_btn.dart';
import 'package:meminjam/shared/widgets/buttons/deactive_btn.dart';
import 'package:meminjam/shared/widgets/textfields/outline_textfields.dart';
import '../../controllers/setup_profile_controller.dart';

class SetupProfilePage extends GetView<SetupProfileController> {
  const SetupProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyle.neutral1),
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
            const Text(
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
              const Text(
                'Setup your account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.neutral1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Setup your account first before you can borrow lots of interesting books!',
                style: TextStyle(fontSize: 16, color: ColorStyle.neutral2),
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorStyle.neutral3,
                          ),
                          child: ClipOval(
                            child: SvgPicture.asset(
                              'src/images/photo_placeholder.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: controller.showPhotoComingSoon,
                      child: const Text(
                        'Change photo profile',
                        style: TextStyle(
                          color: ColorStyle.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Full name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorStyle.neutral1,
                ),
              ),
              const SizedBox(height: 8),
              TextFieldOutlined(
                controller: controller.fullNameController,
                onChanged: (value) => controller.validateForm(),
                labelText: 'Enter your full name',
              ),
              const SizedBox(height: 24),
              const Text(
                'Gender',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorStyle.neutral1,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ColorStyle.neutral3),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedGender.value,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorStyle.neutral2,
                      ),
                      items: controller.genders.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: controller.onChangeGender,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(
          () => controller.isFormValid.value
              ? PrimaryBtn(
                  text: 'Submit',
                  onPressed: controller.isLoading.value
                      ? () {}
                      : controller.submitProfile,
                  borderRadius: 28,
                  height: 56,
                )
              : DeactiveBtn(
                  text: 'Submit',
                  onPressed: () {},
                  borderRadius: 28,
                  height: 56,
                ),
        ),
      ),
    );
  }
}
