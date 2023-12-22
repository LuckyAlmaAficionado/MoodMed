import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/pages/home/ui/home.dart';
import 'package:project_reminder_medicine/pages/login/ui/login.dart';

import '../../controller/authentication_controller.dart';
import '../../controller/notification_controller.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  var authController = Get.put(AuthFirebase());

  @override
  void initState() {
    super.initState();
  }

  nextScreen() {
    NotificationController.initializePermissionHandler();
    NotificationController.initializeNotificationC();
    if (authController.checkLoginStatus()) {
      return const HomePage();
    } else {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSplashScreen(
        duration: 2000,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        nextScreen: nextScreen(),
        splashIconSize: 400,
        splash: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fill,
              width: 400,
              height: 400,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '2023 Moodmed',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            const Gap(2),
            const Icon(
              Icons.copyright,
              color: Colors.black,
              size: 13,
            ),
            const Gap(2),
            Text(
              'Lucky Alma A. R.',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
