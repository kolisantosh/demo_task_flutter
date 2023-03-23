import 'dart:ui';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

 class Constant {

   static String student_email = "";
   static String student_name = "";
   static String student_id = "";
   static String student_user_name = "";
   static String school_id = "";
   static String image = "";
   static String UserD = "";
   static String IoD = "1";
   static String BoD = "2";
   static String LanU = "Urdu";
   static String LanUH = "Urdu/Hindi";
   static String LanENG = "English";
   static String LanAR = "Arabic";
   static String student_status = "";
   static String appname = 'Complete Muslim';
   static int carditemCount = 0;
   static String calendarBar = "Calendar";
   static int val=0;

   static bool isLogin = false;



   static const String base_url = "https://www.completemuslim.org/";
   static const String API_KEY = "DFRERTYGHJUIKLOPHGFRTDERFGTYHNBV";
   static const String limit = "10";
   static const String kids_zoneimages = base_url+"manage/uploads/kids_zone/";
   static const String sliderimages = base_url+"manage/uploads/slider/";
   static const String sub_sliderimages = base_url+"manage/uploads/sub_slider/";
   static const String adhkaarimages = base_url+"manage/uploads/adhkaar/";
   static const String ruqyah_verseimages = base_url+"manage/uploads/ruqyah_verse/";
   static const String blogsimages = base_url+"manage/uploads/blogs/";
   static const String quran_pagesimages = base_url+"manage/uploads/quran_pages/";
   static const String hajj_umrahimages = base_url+"manage/uploads/hajj_umrah/";
   static const String quran_surah_audio = base_url+"manage/uploads/quran_surah_audio/";
   static const String quran_surahurl = base_url+"quran/alquran.cloud/surah/";
   static const String quran_juzurl = base_url+"quran/alquran.cloud/juz/";
   static const String blogsurl = base_url+"single.php?id=";
   static const String quranicaudio = "https://download.quranicaudio.com/verses/";

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

  static const red = Color(0xFFFFEBEE);
  static const red1 = Color(0xFFE53935);
  static const black = Color(0xFF222222);
  static const blackdrawer = Color(0xFF222222);
  static const product_title_name = Color(0xFF222222);
  static const Appname = Color(0xFFF3D876);
  // static const tela = Color(0xC2508D4B);
  static const playerc = Color(0xFFF3D876);
  static const tela = Color(0xFFAC5B5B);
  static const tela2 = Color(0xFFAC5B5B);
  static const tela1 = Color(0xFFFFFFFF);
  static const tela11 = Color(0xFFFFFFFF);
  // static const tela11 = Color(0xFFFEFFD7);
  static const tpay = Color(0xFF10A8DA);
  static const green = Color(0xFFE8F5E9);
  static const green1 = Color(0xFF2E7D32);
  static const telamoredeep = Color(0xFF80CBC4);
  static const onselectedBottomicon = Color(0xFFF3D876);
  static const homeiconcolor = Color(0xFF9B9B9B);
  static const category_button_Icon_color = Color(0xFFFF8F00);
  static const categoryicon = Color(0xFF222222);
  static const carticon = Color(0xFF9B9B9B);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
  static const mrp = Color(0xFF979797);
  static const sellp = Color(0xFF2AA952);
  static const white = Color(0xFFFFFFFF);
  static const button_text_color = Color(0xFF607D8B);
  static const success = Color(0xFF2AA952);
  static const pink = Color(0xFFFF4081);
  static const boxColor1 = Color(0xFF70D0C5);

//  static const boxColor1 = Color(0xFF5171ff);
  static const boxColor2 = Color(0xFFABDCFF);
  static const checkoup_paybuttoncolor = Color(0xFF40C4FF);

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
Widget showCircle(){
   return Align(
     alignment: Alignment.center,
     child: Padding(
       padding: EdgeInsets.only(left: 15,bottom: 18),
       child: Container(
         padding: const EdgeInsets.all(5.0),
         decoration: new BoxDecoration(
           shape: BoxShape.circle,
           color: AppColors.telamoredeep,
         ),
         child: Text('${Constant.carditemCount}',
             style: TextStyle(color: Colors.white, fontSize: 15.0)),
       ),
     ),

   );

}

void showLongToast(String s) {
  Fluttertoast.showToast(
   // textColor: Colors.black,
    msg: s,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 1,
//       backgroundColor: AppColors.tela,
//       textColor: AppColors.Appname,
      fontSize: 16.0
  );
}
