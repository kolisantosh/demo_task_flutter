import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testecommerce/controller/categoryController.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {

  final myController =Get.put(CategoryController());
  var id=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: List.generate(6, (index) =>CategoryWiget(index)
        )
      ),
    );
  }

  Widget CategoryWiget(index) {
    return  InkWell(
      onTap: (){
        setState(() {
          id=index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: id==index?Colors.amber:Colors.white,
            width: 2,
          )
        ),
        child: Column(
          children: [
            CircleAvatar(
              child: Image.network("https://soliloquywp.com/wp-content/uploads/2019/02/nb_pss_2.jpg"),
            ),
            Container(child: Text("Category "+index.toString()),)
          ],
        ),
      ),
    );
  }
}
