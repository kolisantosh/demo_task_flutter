import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testecommerce/controller/cartController.dart';
import 'package:testecommerce/models/productModel.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductModel item;
   ProductDetailsPage({required this.item});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final myCartController=Get.put(CartController());
 var count=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Stack(
                children: [
                  Container(
                    height: 350,
                      child: Image.network(widget.item.image)),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      color: Colors.black12,
                      child: ListView(
                        shrinkWrap: true,
                        children: List.generate(4, (index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue
                          ),
                        )),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  )
                ),
                child: ListView(
                  children: [
                    Container(
                      child: Text(widget.item.description,
                      overflow: TextOverflow.clip,
                      maxLines: 5,),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.item.price.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                    Container(
                      color: Colors.black12,
                      child: Row(
                        children: [
                          IconButton(icon: Icon(Icons.add), onPressed: () { setState(() {
                            count++;
                          }); },),
                          Text('$count'),
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  if(count>0){
                                    count--;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove))
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        myCartController.addtoCart(widget.item,count);
                      },
                      child: Container(
                        color: Colors.amber,
                        child: Text("Card"),
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
