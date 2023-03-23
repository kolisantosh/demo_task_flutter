import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/home_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = Get.put(HomeController1());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: Text("Even Odd Game"),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => Stack(
                  children: myController.mlist.length == 0
                      ? [_buildDraggableWithNoitem()]
                      : myController.mlist
                          .map((num) => Draggable(
                              data: num,
                              child: _buildDraggable(num.toString()),
                              feedback: _buildDraggable(num.toString()),
                              childWhenDragging: Container(
                                height: 100,
                                width: 100,
                              )))
                          .toList(),
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDragTarget(
                    text: 'Even', color: Colors.lime, acceptType: 1),
                _buildDragTarget(text: 'Odd', color: Colors.red, acceptType: 0),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  myController.restartGame();
                },
                child: Text('Restart'))
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableWithNoitem() => Container(
        alignment: Alignment.center,
        color: Colors.black,
        height: 100,
        width: 100,
        child: Text(
          "No Item",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      );

  Widget _buildDraggable(str) => Container(
        alignment: Alignment.center,
        color: Colors.green,
        height: 100,
        width: 100,
        child: Text(
          str,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      );

  Widget _buildDragTarget(
          {required String text,
          required Color color,
          required int acceptType}) =>
      DragTarget<int>(
        builder: (context, acceptData, rejectData) => Stack(
          children: [
            Container(
              alignment: Alignment.center,
              color: color,
              height: 100,
              width: 100,
              child: Text(
                text,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ),
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {
          myController.checkCorrectAnswer(data, acceptType);
        },
      );
}
