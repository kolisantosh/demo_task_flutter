

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class Constant {

   static const String Server_KEY = "AAAAWGiodzE:APA91bFsghZOC2VxmkCoXgojf5MonMgf-UiQlqqgWE_JI-jHvac-Sgt2K_Dxacazddhu0nTri75owHS2zyvZkiQd0UiBoeOWipnuWi0y8TYG9BDjt4j2IYLuibq5drmSngp3CAwiBcBK";
   static bool isLogin = false;
   static bool check = false;
   static String Mobile = "";
   static String email11 = "maxeyfresh@Royalwelttechnologies.Com";
   static String name = " ";
   static String email = " ";
   static String image = "";
   static int itemcount = 0;
   static int wishlist = 0;
   static int carditemCount = 0;
   static double totalAmount = 0;
   static double shipingAmount = 0;
  static String newTokenId="";


 }



class AppColors {

  static const red = Color(0xFFE3F2FD);
  static const black = Color(0xFF222222);
  static const blackdrawer = Color(0xFF222222);
  static const product_title_name = Color(0xFF222222);
  static const App_H_name = Color(0xFF222222);
  static const Appname = Color(0xFFFFFFFF);

  static const tela = Color(0xFF000000);
  // static const tela = Color(0xFF499DC4);
  static const tela1 = Color(0xFFFFFFFF);
  static const teladep = Color(0xFF222222);
  static const telamoredeep = Color(0xFF40C4FF);
  static const onselectedBottomicon = Color(0xFF000000);
  static const homeiconcolor = Color(0xFFFF8F00);
  static const category_button_Icon_color = Color(0xFFFF8F00);
  static const categoryicon = Color(0xFF00BCD4);
  static const carticon = Color(0xFFFF80AB);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
  static const mrp = Color(0xFF979797);
  static const sellp = Color(0xFF2AA952);
  static const white = Color(0xFFFFFFFF);
  static const button_text_color = Color(0xFF607D8B);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);
  static const pink = Color(0xFFFF4081);
  static const boxColor1 = Color(0xFF1E88E5);
  static const boxColor2 = Color(0xFFBBDEFB);
  static const checkoup_paybuttoncolor = Color(0xFF40C4FF);
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
           // color: Colors.blue,
         ),
         child: Text('${Constant.carditemCount}',
             style: TextStyle(color: Colors.white, fontSize: 15.0)),
       ),
     ),

   );

}
