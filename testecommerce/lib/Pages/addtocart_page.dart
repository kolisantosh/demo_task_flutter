import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testecommerce/controller/cartController.dart';
import 'package:testecommerce/models/cartModel.dart';

class AddtoCartPage extends StatefulWidget {
  const AddtoCartPage({Key? key}) : super(key: key);

  @override
  State<AddtoCartPage> createState() => _AddtoCartPageState();
}

class _AddtoCartPageState extends State<AddtoCartPage> {
  final myController=Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          Stack(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag)),
              CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(myController.plist.length.toString(),style: TextStyle(color: Colors.white),),
              )
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          Obx(()=>ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: myController.plist.length,
            itemBuilder: (BuildContext context, int index) {
              CartModel item=myController.plist[index];
              return CartWidget(item);
            },
          )

          )
        ],
      )

    );
  }

  Widget CartWidget(item) {
    return  Row(
      children: [
        Card(
          elevation: 2,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(item.image),
        ),
        Column(
          children: [

            Container(child: Text(item.title.toString())),
            Container(child: Text(item.decription.toString())),

          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

          ],
        )
      ],
    );
  }
}
