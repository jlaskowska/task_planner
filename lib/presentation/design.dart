import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    appBarTheme:
        const AppBarTheme(elevation: 0, backgroundColor: AppColors.tagBlue),
    fontFamily: GoogleFonts.quicksand().fontFamily,
    primaryColor: AppColors.primaryBlue,
    primaryColorLight: AppColors.lightBlue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme().apply(
      bodyColor: AppColors.fontColor,
      displayColor: AppColors.fontColor,
    ));

class AppColors {
  AppColors._();

  static const primaryBlue = Color(0xff00d2ff);
  static const lightBlue = Color(0xffcfe7f0);
  static const gray = Color(0xffdedede);

  static const fontColor = Color(0xff172741);

  static const tagBlue = Color(0xff65c2f9);
  static const tagYellow = Color(0xfff7b369);
  static const tagPink = Color(0xfff9807c);
}
