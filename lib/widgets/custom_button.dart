import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonC extends StatelessWidget {
  final String textButton;
  final void Function()? onTap;
  const ButtonC({
    super.key,
    required this.textButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        color: const Color.fromARGB(255, 54, 124, 254),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              textButton,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
