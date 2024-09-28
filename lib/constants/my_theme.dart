import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = const Color(0xff005698);
  static Color backgroundLight = const Color(0xffDFECDB);
  static Color greenColor = const Color(0xffa952b5);
  static Color redColor = const Color(0xffEC4B4B);
  static Color blackColor = const Color(0xff383838);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color backgroundDark = const Color(0xff060E1E);
  static Color darkBlack = const Color(0xff141922);
  static Color grayColor = const Color(0xff96969a);
  static Color backgroundMint = const Color(0xff00849A);
  static Color backgroundBlue = const Color(0xff0065D8);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryLight,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryLight,
      unselectedItemColor: grayColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      shape: StadiumBorder(
          side: BorderSide(
            color: MyTheme.whiteColor,
        width: 5,
      )),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
      titleMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor),
      titleSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
    ),
  );
}