import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.tagBlue,
  ),
  fontFamily: GoogleFonts.quicksand().fontFamily,
  primaryColor: AppColors.primaryBlue,
  primaryColorLight: AppColors.lightBlue,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyText2: const TextTheme().bodyText2?.copyWith(
          color: AppColors.fontColor,
        ),
  ),
);

final darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xff232936),
  ),
  fontFamily: GoogleFonts.quicksand().fontFamily,
  primaryColor: const Color(0xff8d63ee),
  primaryColorLight: const Color(0xffcab3fc).withOpacity(0.5),
  scaffoldBackgroundColor: const Color(0xff2b3140),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: Colors.white,
    ),
  ),
);

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
