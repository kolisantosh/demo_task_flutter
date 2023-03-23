import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testecommerce/Pages/ProductDetailsPage.dart';
import 'package:testecommerce/controller/cartController.dart';
import 'package:testecommerce/controller/productController.dart';
import 'package:testecommerce/models/productModel.dart';
import 'package:testecommerce/widgets/categoryListWidget.dart';
import 'package:testecommerce/widgets/drawerList.dart';
import 'package:testecommerce/widgets/homeheaderWidget.dart';
import 'package:testecommerce/widgets/imagesliderWidget.dart';
import 'package:testecommerce/widgets/recenctListWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController=Get.put(ProductController());
  final mycartController=Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.menu,color: Colors.black,),
        ),
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.search,color: Colors.black,))
        ],
      ),
      drawer: DrawerList(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              HomeHeaderWidget(),
              ImageSliderWidget(),
              ListTile(title: Text("Category"),),
              CategoryListWidget(),
              ListTile(title: Text("Popular Products"), ),
              Obx(()=> myController.isLoading.value?Center(child: CircularProgressIndicator(),):Container(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemCount: myController.plist.length,
                  itemBuilder: (BuildContext context, int index) {
                    ProductModel item=myController.plist[index];
                    return Card(
                      child: InkWell(
                        onTap: (){
                          Get.to(ProductDetailsPage(item: item,));
                        },
                        child: Container(
                          width: 150,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height:100,
                                    child: Image.network(item.image),
                                  ),
                                  Positioned(
                                    bottom: -5,
                                    right: -0,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.amber,
                                        child: InkWell(
                                            onTap: (){
                                              mycartController.addtoCart(item,1);
                                            },
                                            child: Icon(Icons.shopping_bag,color: Colors.white,))),
                                  )
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Text(item.title,overflow: TextOverflow.clip,maxLines: 2,),
                                        ),
                                        Container(
                                          child: Text(item.description,overflow: TextOverflow.clip,maxLines: 2,),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Text(item.price.toString(),style: TextStyle(color: Colors.black,fontSize: 18),))
                                ],
                              ),


                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
              RecenctlyListWidget(),

          ],),
        ),
      ),
    );
  }
}
