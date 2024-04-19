import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController  controller;
  final String hinText;
  final bool obsureText;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hinText,
    required this.obsureText,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF41B54A);

    return TextFormField(
      obscureText: obsureText,
      controller: controller,
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primary.withOpacity(0.90),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primary.withOpacity(0.90),
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primary.withOpacity(0.90),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primary.withOpacity(0.90),
          ),
        ),
        hintText: hinText,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      validator: validator,
    );
  }
}
