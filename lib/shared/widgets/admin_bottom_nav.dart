import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/features/admin/homepage/controllers/homepage_controller.dart';
import 'package:meminjam/features/admin/homepage/views/ui/admin_homepage.dart';
import 'package:meminjam/features/admin/profile/views/ui/admin_profile_page.dart';
import 'package:meminjam/features/admin/stock/views/ui/admin_stock_page.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class AdminBottomNav extends StatelessWidget {
  AdminBottomNav({super.key});

  final controller = Get.find<HomepageController>();

  final List<Widget> _pages = [
    const AdminHomepage(),
    const AdminStockPage(),
    const AdminProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => _pages[controller.currentIndex]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: controller.changePage,
          selectedItemColor: ColorStyle.primary,
          unselectedItemColor: ColorStyle.neutral2,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: 'Stock',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
