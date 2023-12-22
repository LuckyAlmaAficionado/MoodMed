import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackbarC {
  static failedSnackbar(String title, String subTitle) {
    return Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 18,
        ),
      ),
      messageText: Text(
        subTitle,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.normal,
        ),
      ),
      margin: const EdgeInsets.all(20),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 1000),
    );
  }

  static successSnackbar(String title, String subTitle) {
    return Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 18,
        ),
      ),
      messageText: Text(
        subTitle,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.normal,
        ),
      ),
      margin: const EdgeInsets.all(20),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 1000),
    );
  }
}
