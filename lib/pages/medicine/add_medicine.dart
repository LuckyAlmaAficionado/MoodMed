import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';
import 'package:project_reminder_medicine/routes/routes_name.dart';
import 'package:project_reminder_medicine/widgets/custom_snackbar.dart';

// ignore: must_be_immutable
class TambahObat extends StatelessWidget {
  TambahObat({super.key});

  TextEditingController namaObatC = TextEditingController();
  TextEditingController dosisObatC = TextEditingController();
  TextEditingController waktuPenggunaanC = TextEditingController();
  TextEditingController kegunaaanC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MASUKAN NAMA OBAT TERBARU',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const Gap(20),
            TambahObatField(hint: 'Nama Obat', controller: namaObatC),
            TambahObatField(hint: 'Dosis Obat', controller: dosisObatC),
            TambahObatField(hint: 'Kegunaaan Obat', controller: kegunaaanC),
            const Gap(10),
            SizedBox(
              height: 45,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepOrange,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    Get.put(FirestoreFirebase()).createdNewMedicine(
                      namaObatC.text,
                      dosisObatC.text,
                      kegunaaanC.text,
                    );
                    SnackbarC.successSnackbar(
                        'Success', 'medicine add to database');
                    await Future.delayed(const Duration(seconds: 2));

                    Get.toNamed(RouteName.doctorPage);
                  },
                  child: Center(
                    child: Text(
                      'SUBMIT',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TambahObatField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const TambahObatField({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
