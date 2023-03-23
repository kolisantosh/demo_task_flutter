import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/blind_game_page.dart';
import 'package:untitled/home_binding.dart';

import 'my_home_page.dart';
import 'tictactoe_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: HomeBinding(),
      home: BlindGamePage(),
    );
  }
}

