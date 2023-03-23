import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testecommerce/controller/categoryController.dart';

class RecenctlyListWidget extends StatefulWidget {
  const RecenctlyListWidget({Key? key}) : super(key: key);

  @override
  State<RecenctlyListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<RecenctlyListWidget> {

  final myController =Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: List.generate(6, (index) =>pUIWiget(index)
        )
      ),
    );
  }

  Widget pUIWiget(index) {
    return  Row(
      children: [
        CircleAvatar(
          child: Image.network("https://soliloquywp.com/wp-content/uploads/2019/02/nb_pss_2.jpg"),
        ),
        Container(child: Text("Product "+index.toString()),)
      ],
    );
  }
}
