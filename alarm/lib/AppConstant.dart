import 'dart:ui';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 class Constant {

   static String appname = 'Alarm';

   static formatBytes(bytes, decimals) {
     if (bytes == 0) return 0.0;
     var k = 1024,
         dm = decimals <= 0 ? 0 : decimals,
         sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
         i = (log(bytes) / log(k)).floor();
     return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
   }
 }



class AppColors {

  static const black = Color(0xFF000000);
  static const white = Color(0xFFffffff);
  static const Appname = Color(0xFFffffff);
  static const tela = Color(0xFF427DF1);


  //Colors for theme
  static Color lightPrimary = Color(0xfff2f3f7);
  static Color darkPrimary = Color(0xff121212);
  static Color lightAccent = Colors.blue;
  static Color darkAccent = Colors.blue;
  static Color lightBG = Color(0xfff2f3f7);
  static Color darkBG = Color(0xff191919);


  static const kCardColor = Color(0xFF111328);
  static const kHomeCardsColor = Color(0xfff2f3f7);
  static const kCoursesIconColor = Color(0xffF2C94C);
  static const kCalendarIconColor = Color(0xffF26419);
  static const kFeesIconColor = Color(0xff6FCF97);
  static const kFacultyIconColor = Color(0xff2D9CDB);
  static const kWebsiteIconColor = Color(0xffBB6BD9);
  static const kAntiRaggingIconColor = Color(0xffEB5757);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
  );

}