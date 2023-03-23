
import 'package:get/get.dart';
import 'package:testecommerce/controller/serviceProvide.dart';

class ProductController extends GetxController{

  RxList plist=List.empty(growable: true).obs;
  var isLoading=true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProduct();
  }

  getProduct()async{
    isLoading(true);
    try {
      var txns = await ServiceProvider.fetchgetProduct();
      if (txns != null) {
        isLoading(false);
        plist.addAll(txns);
      }
    } catch (e) {

    } finally {
      isLoading(false);
    }

  }
}