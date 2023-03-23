import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingcart/controllers/cart_controller.dart';
import 'package:shoppingcart/controllers/payments_controller.dart';
import 'package:shoppingcart/controllers/product_controller.dart';
import 'package:shoppingcart/screens/splash/splash.dart';

import 'constants/firebase.dart';
import 'controllers/appController.dart';
import 'controllers/authController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialization.then((value){
    Get.put(AppController());
    Get.put(UserController());
    Get.put(ProducsController());
    Get.put(CartController());
    Get.put(PaymentsController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Cart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
