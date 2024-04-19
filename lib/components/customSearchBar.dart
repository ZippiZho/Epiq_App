import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  final bool onFocus;
  final Widget? preficIcon;
  final Widget? surficeIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.hinText,
    required this.onChanged,
    this.preficIcon,
    required this.onFocus,
    this.surficeIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    const Color backgroundInput = Color(0xFFF5F5F5);
    const Color background = Color(0xFF03010E);
    const Color colorText = Color(0xFFEA1818);

    return TextFormField(
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: background,
      ),
      autofocus: onFocus,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: preficIcon,
        fillColor: backgroundInput,
        suffixIcon: surficeIcon,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.10)),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.10)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
        hintText: hinText,
        errorStyle: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorText,
        ),
        hintStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: background,
        ),
      ),
      validator: validator,
    );
  }
}
