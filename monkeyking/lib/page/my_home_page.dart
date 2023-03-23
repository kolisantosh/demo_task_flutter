import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monkeyking/widgets/birjsWid.dart';
import 'package:monkeyking/widgets/my_ninja.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double ninjaYaxis = 0.8;
  double ninjaXaxis = -1;
  double birjYone = 0.3;
  double birjYtwo = -0.8;
  var tap = false;
  var gamehasStart = false;

  var speed = 100;
  var scr = 20;
  int score = 0;
  int highScore = 0;

  Timer? scoreTimer;

  void startGame() {
    gamehasStart = true;
    scoreTimer = Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        if (gamehasStart) {
          setState(() {
            score++;
          });
        }
      },
    );
    Timer.periodic(Duration(milliseconds: speed), (timer) {

      if (birjYone > 1) {
        setState(() {
          birjYone -= 2.2;
        });
      } else {
        setState(() {
          birjYone += 0.1;
        });
      }

      if (birjYtwo > 1) {
        setState(() {
          birjYtwo -= 2.2;
        });
      } else {
        setState(() {
          birjYtwo += 0.1;
        });
      }

      if (ninjaXaxis == -1 && (birjYone >= 0.58 && birjYone <= 0.80)) {
        timer.cancel();
        scoreTimer!.cancel();
        _showDialog();
      }
      if (ninjaXaxis == 1 && (birjYtwo >= 0.58 && birjYtwo <= 0.80)) {
        timer.cancel();
        scoreTimer!.cancel();
        _showDialog();

      }
    });
  }

  addscore() {
    setState(() {
      Future.delayed(const Duration(seconds: 10), () {
        score+=10;
      });
    });
    if (score == 15) {
      // startGame();
    }
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.amber,
            title: Text("Game Over"),
            content: Text("Score " + score.toString()),
            actions: [TextButton(onPressed: () {
              setState(() {
                tap = false;
                gamehasStart = false;
                score = 0;
                speed = 100;
                scr = 20;
                ninjaYaxis = 0.8;
                ninjaXaxis = -1;
                birjYone = 0.3;
                birjYtwo = -0.8;
              });
              Navigator.pop(context,false);
            }, child: Text("Play Again"))],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tap = !tap;
          tap ? ninjaXaxis = 1 : ninjaXaxis = -1;
        });
        if (!gamehasStart) startGame();
      },
      child: Scaffold(
        backgroundColor: Colors.pink,
        appBar: AppBar(
          title: Text("Score: $score"),
        ),


        body: Stack(
          children: [

            AnimatedContainer(
              alignment: const Alignment(1, 0),
              duration: const Duration(milliseconds: 0),
              child: Container(
                width: 10,
                color: Colors.green,
              ),
            ),
            AnimatedContainer(
              alignment: const Alignment(-1, 0),
              duration: const Duration(milliseconds: 0),
              child: Container(
                width: 10,
                color: Colors.green,
              ),
            ),
            Container(
              alignment: Alignment(0, 0),
              child: Text(
                gamehasStart ? "" : "𝕋𝕒𝕡 𝕥𝕠 ℙ𝕝𝕒𝕪",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            AnimatedContainer(
              alignment: Alignment(ninjaXaxis, ninjaYaxis),
              duration: const Duration(milliseconds: 250),
              child: tap ? Transform(alignment:Alignment.center,transform: Matrix4.rotationY(pi),child: MyNinja()) : MyNinja(),
            ),
            AnimatedContainer(
              alignment: Alignment(1, birjYtwo),
              duration: const Duration(milliseconds: 0),
              child: BirjWidget(200.0),
            ),
            AnimatedContainer(
              alignment: Alignment(-1, birjYone),
              duration: const Duration(milliseconds: 10),
              child: BirjWidget(200.0),
            ),
          ],
        ),
      ),
    );
  }
}
