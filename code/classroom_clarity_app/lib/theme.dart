import 'package:flutter/material.dart';

/*
 Here is where we will constants relating to the theme of our app, such as
 color scheme, font settings, and other UI objects as necessary
 */

class AppColors {
  // Flutter colors are RGB color codes prefixed with an opacity value.
  // The FF represents full opacity
  //LOGO colors
  static const snow = Color(0xFFFCF7F8);
  static const grey = Color(0xFFCED3DC);
  static const dullPurple = Color(0xFFABA9C3);
  static const denim = Color(0xFF275DAD);
  static const darkGrey = Color(0xFF5B616A);
  static const darkRed = Color(0xFF64113F);

  //extras
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  // RYG Gradient
  static const red1 = Color(0xfff48474);
  static const red2 = Color(0xfffb957c);
  static const red3 = Color(0xfffcb382);
  static const yellow1 = Color(0xfffcc784);
  static const yellow2 = Color(0xfff4e586);
  static const yellow3 = Color(0xffdfee79);
  static const green1 = Color(0xffdcec74);
  static const green2 = Color(0xffccec6d);
  static const green3 = Color(0xffaef35b);
  static const green4 = Color(0xff9cf44c);
  static const green5 = Color(0xff8df347);

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