import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaperDownloader/pages/babyphotos.dart';
// import 'package:wallpaperDownloader/pages/babyphotos.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Photosview(),
    );
  }
}
