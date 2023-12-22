import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';
import 'package:project_reminder_medicine/routes/routes_name.dart';

// ignore: must_be_immutable
class DoctorPage extends StatelessWidget {
  DoctorPage({super.key});

  var fireC = Get.put(FirestoreFirebase());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'pemantauan psikiater'.toUpperCase(),
              style: GoogleFonts.candal(
                fontWeight: FontWeight.w600,
                fontSize: 26,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(30),
            SizedBox(
              height: 100,
              width: double.maxFinite,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 37, 113, 188),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.toNamed(RouteName.pasien);
                  },
                  child: Center(
                    child: Text(
                      'INFORMASI OBAT PASIEN',
                      style: GoogleFonts.candal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(30),
            SizedBox(
              height: 100,
              width: double.maxFinite,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 142, 202, 230),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.toNamed(RouteName.moodTracker);
                  },
                  child: Center(
                    child: Text(
                      'MOOD TRACKER PASIEN',
                      style: GoogleFonts.candal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(20),
            SizedBox(
              height: 100,
              width: double.maxFinite,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 183, 3),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.toNamed(RouteName.addMedicine);
                  },
                  child: Center(
                    child: Text(
                      'OBAT PASIEN',
                      style: GoogleFonts.candal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(20),
            SizedBox(
              height: 100,
              width: double.maxFinite,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 234, 119, 0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.toNamed(RouteName.tambahObat);
                  },
                  child: Center(
                    child: Text(
                      'TAMBAH OBAT',
                      style: GoogleFonts.candal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(20),
            SizedBox(
              height: 100,
              width: double.maxFinite,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.offAllNamed(RouteName.login);
                  },
                  child: Center(
                    child: Text(
                      'LOGOUT',
                      style: GoogleFonts.candal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
