import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/shared/controllers/auth_controller.dart';
import 'package:meminjam/shared/widgets/buttons/primary_btn.dart';

class AdminSettingPage extends StatelessWidget {
  AdminSettingPage({super.key});
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("Halaman Setting")),
          PrimaryBtn(
            text: "Logout",
            onPressed: () {
              authC.logout();
            },
            height: 50,
          ),
        ],
      ),
    );
  }
}
