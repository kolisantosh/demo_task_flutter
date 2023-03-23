
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testecommerce/models/productModel.dart';

class ServiceProvider extends GetConnect{
  static var client = http.Client();

  static Future<List<ProductModel>> fetchgetProduct() async{
      var res = await client.get(Uri.parse("https://fakestoreapi.com/products"));
      if (res.statusCode == 200) {
        return welcomeFromJson(res.body);
      } else {
        return [];
      }
  }
}