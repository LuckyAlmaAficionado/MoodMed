import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldC extends StatelessWidget {
  final TextEditingController controller;
  final bool obsecureText;
  final String hintText;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  const TextFieldC({
    super.key,
    required this.controller,
    required this.obsecureText,
    required this.hintText,
    required this.textInputAction,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        cursorColor: Colors.grey.shade500,
        controller: controller,
        obscureText: obsecureText,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
