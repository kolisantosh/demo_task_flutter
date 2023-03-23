import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testecommerce/controller/cartController.dart';
import 'package:testecommerce/controller/productController.dart';

class ProductBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => CartController());


  }


}