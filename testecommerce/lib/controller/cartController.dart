
import 'package:get/get.dart';
import 'package:testecommerce/controller/serviceProvide.dart';
import 'package:testecommerce/models/cartModel.dart';
import 'package:testecommerce/models/productModel.dart';

class CartController extends GetxController{

  RxList plist=List.empty(growable: true).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  addtoCart(ProductModel product,count){
    CartModel cartModel=CartModel(price:product.price,description:product.description,title:product.title,image:product.image,totalItem:count,id: product.id);
    plist.add(product);
  }

  deleteItem(item){
    plist.removeWhere((element) => element.id=item.id);
  }

}