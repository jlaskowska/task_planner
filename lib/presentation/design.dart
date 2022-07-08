import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: _lightColors.appBarColor,
  ),
  fontFamily: GoogleFonts.quicksand().fontFamily,
  primaryColor: _lightColors.primaryColor,
  primaryColorLight: _lightColors.primaryColorLight,
  scaffoldBackgroundColor: _lightColors.scaffoldBackgroundColor,
  textTheme: TextTheme(
    bodyText2: const TextTheme().bodyText2?.copyWith(
          color: _lightColors.textColor,
        ),
  ),
);

final darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: _darkColors.appBarColor,
  ),
  fontFamily: GoogleFonts.quicksand().fontFamily,
  primaryColor: _darkColors.primaryColor,
  primaryColorLight: _darkColors.primaryColorLight,
  scaffoldBackgroundColor: _darkColors.scaffoldBackgroundColor,
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: _darkColors.textColor,
    ),
  ),
);

const _lightColors = _AppColors(
  primaryColor: Color(0xff00d2ff),
  primaryColorLight: Color(0xffcfe7f0),
  appBarColor: TagColors.blue,
  scaffoldBackgroundColor: Colors.white,
  textColor: Color(0xff172741),
);

const _darkColors = _AppColors(
  primaryColor: Color(0xff8d63ee),
  primaryColorLight: Color.fromRGBO(220, 179, 252, 0.6),
  appBarColor: Color(0xff232936),
  scaffoldBackgroundColor: Color(0xff2b3140),
  textColor: Colors.white,
);

class _AppColors {
  final Color primaryColor;
  final Color primaryColorLight;
  final Color appBarColor;
  final Color scaffoldBackgroundColor;
  final Color textColor;

  const _AppColors({
    required this.primaryColor,
    required this.primaryColorLight,
    required this.appBarColor,
    required this.scaffoldBackgroundColor,
    required this.textColor,
  });
}

class TagColors {
  TagColors._();

  static const blue = Color(0xff65c2f9);
  static const yellow = Color(0xfff7b369);
  static const pink = Color(0xfff9807c);
}
