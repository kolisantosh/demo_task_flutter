import 'package:flutter/material.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(title: Text("Hello surender,",style: TextStyle(color: Colors.black),),
      subtitle: Text("Lets get somethings"),),
    );
  }
}
