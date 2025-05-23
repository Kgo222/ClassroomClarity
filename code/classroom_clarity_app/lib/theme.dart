import 'package:flutter/material.dart';

/*
 Here is where we will constants relating to the theme of our app, such as
 color scheme, font settings, and other UI objects as necessary
 */

class AppColors {
  // Flutter colors are RGB color codes prefixed with an opacity value.
  // The FF represents full opacity
  //LOGO colors
  static const Color snow = Color(0xFFFCF7F8);
  static const Color grey = Color(0xFFCED3DC);
  static const Color dullPurple = Color(0xFFABA9C3);
  static const Color denim = Color(0xFF275DAD);
  static const Color darkGrey = Color(0xFF5B616A);
  static const Color darkRed = Color(0xFF64113F);

  //extras
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // RYG Gradient
  static const Color red1 = Color(0xfff48474);
  static const Color red2 = Color(0xfffb957c);
  static const Color red3 = Color(0xfffcb382);
  static const Color red4 = Color(0xfffcc784);
  static const Color yellow1 = Color(0xfff4e586);
  static const Color yellow2 = Color(0xffdfee79);
  static const Color yellow3 = Color(0xffccec6d);
  static const Color green1 = Color(0xffaef35b);
  static const Color green2 = Color(0xff9cf44c);
  static const Color green3 = Color(0xff8df347);

}

ColorScheme colorScheme = const ColorScheme.dark(
  primary: AppColors.denim,
  onPrimary: AppColors.snow,
  secondary: AppColors.darkRed,
  onSecondary: AppColors.dullPurple,
  surface: AppColors.snow,
  background: AppColors.snow,
);
final appTheme = ThemeData.from(
    colorScheme: colorScheme
);