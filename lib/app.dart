import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'configs/pages/page.dart';
import 'configs/routes/route.dart';
import 'shared/bindings/global_binding.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meminjam',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF643FDB)),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      initialBinding: GlobalBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
