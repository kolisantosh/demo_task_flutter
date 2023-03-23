import 'package:flutter/material.dart';

class MyNinja extends StatelessWidget {
  const MyNinja({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Image.asset("assets/images/ninja.png"),
    );
  }
}