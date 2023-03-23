import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int? itemCount;

  const HomeScreen({Key? key, this.itemCount}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedContainer;
  int? lastSelected;
  List colorsList = [Colors.red, Colors.green, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1),
          shrinkWrap: true,
          itemCount: widget.itemCount,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  lastSelected=selectedContainer;
                  selectedContainer = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: selectedContainer == index
                        ? colorsList[0]
                        : lastSelected == index
                            ? colorsList[1]
                            :selectedContainer==widget.itemCount? colorsList[2]:Colors.transparent,
                    border: Border.all(color:Colors.black)),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              ),
            );
          }),
    );
  }
}
