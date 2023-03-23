import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class BlindGamePage extends StatefulWidget {
  const BlindGamePage({Key? key}) : super(key: key);

  @override
  _BlindGamePageState createState() => _BlindGamePageState();
}

class _BlindGamePageState extends State<BlindGamePage> {
  final myController = Get.put(HomeController2());

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(()=>GridView.builder(
              shrinkWrap: true,
                itemCount: myController.mlist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (orientation == Orientation.portrait) ? 3 : 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.91
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Tile(data: myController.mlist[index],
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: (){
              myController.restartGame();
            }, child: Text("Refresh")),

            SizedBox(
              height: 10,
            ),
            Container(
                height: 150,
                alignment: Alignment.center,
                color: Colors.lightBlue,
                child: Text("Sroce\n"+myController.sroce.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  var data;
  Tile({this.data,});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool visible=false;
  final myController = Get.put(HomeController2());

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: visible,
      child: InkWell(
        onTap: (){
          setState(() {
            visible=!visible;
            myController.checkCorrectAnswer(widget.data.toString());

          });
        },
        child: Container(
          color: Colors.pink,
          alignment: Alignment.center,
          child: Text(visible?widget.data.toString():"",style: TextStyle(color: Colors.white,fontSize: 18),),
        ),
      ),
    );
  }
}

