import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/features/admin/profile/controllers/profile_controller.dart';
import 'package:meminjam/features/admin/profile/views/components/menu_items.dart';
import 'package:meminjam/shared/controllers/auth_controller.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/shared/widgets/buttons/primary_btn.dart';

class AdminProfilePage extends GetView<ProfileController> {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Setting',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorStyle.neutral1,
                  ),
                ),
                const SizedBox(height: 24),

                // Profile Header
                Obx(
                  () => Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: ColorStyle.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            controller.userProfile.value != null
                                ? controller.userProfile.value!.name[0]
                                      .toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorStyle.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.userProfile.value?.name ??
                                  'Loading...',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorStyle.neutral1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.userProfile.value?.email ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: ColorStyle.neutral2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorStyle.neutral1,
                  ),
                ),
                const SizedBox(height: 16),
                menuItems(Icons.person_outline, 'Personal details'),
                menuItems(Icons.card_membership_outlined, 'Membership'),
                menuItems(Icons.notifications_outlined, 'Notifications'),
                menuItems(Icons.settings_outlined, 'Account settings'),
                menuItems(Icons.language_outlined, 'Language'),
                const SizedBox(height: 24),

                const Text(
                  'General',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorStyle.neutral1,
                  ),
                ),
                const SizedBox(height: 16),
                menuItems(Icons.help_outline, 'FAQs & Help'),
                menuItems(Icons.description_outlined, 'Policies & Terms'),
                menuItems(Icons.star_outline, 'Give app rating'),
                const SizedBox(height: 24),

                PrimaryBtn(
                  text: "Logout",
                  onPressed: () => authC.logout(),
                  height: 50,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
