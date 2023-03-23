
import 'package:get/get.dart';
import 'package:testecommerce/models/productModel.dart';

class CategoryController extends GetxController{

  RxList plist=List.empty(growable: true).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getProduct();
  }

  getProduct(){



  }
}