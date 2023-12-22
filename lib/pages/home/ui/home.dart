import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/afirmasi_controller.dart';
import 'package:project_reminder_medicine/controller/authentication_controller.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';
import 'package:project_reminder_medicine/routes/routes_name.dart';

import '../widgets/button_medicine.dart';
import '../widgets/button_mood.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var authC = Get.put(AuthFirebase());
  var fireC = Get.put(FirestoreFirebase());
  var afirmasiC = Get.put(AfirmasiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background_home.png',
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          Get.toNamed(RouteName.doctorPage);
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          authC.logoutUser().then(
                              (value) => Get.offAllNamed(RouteName.login));
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.red.shade500,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(50),
                  Text(
                    'Hello,',
                    style: GoogleFonts.poppins(
                      fontSize: 21,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName!
                        .toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const MaxGap(30),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/path_button.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 115, 128, 243),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Affirmasi up...!',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          afirmasiC.gratitudeMessages[Random()
                              .nextInt(afirmasiC.gratitudeMessages.length)],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const MaxGap(30),
                  Text(
                    'Apa yang kamu perlukan?',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const Gap(20),
                  ButtonMoodTracker(
                    onTap: () {
                      Get.toNamed(RouteName.question);
                    },
                  ),
                  const Gap(10),
                  ButtonMedicine(
                    onTap: () {
                      Get.toNamed(RouteName.medicine);
                    },
                  ),
                  const Gap(10),
                  Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () => Get.toNamed(RouteName.emergency),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            const Gap(10),
                            Text(
                              'Emergency Call',
                              style: GoogleFonts.robotoFlex(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
