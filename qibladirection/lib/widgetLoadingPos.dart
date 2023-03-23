import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qibladirection/consts.dart';
import 'package:qibladirection/languages.dart';

// Loading position widget
Widget    WidgetLoadingPos(language, screenSize) {
  return  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              SpinKitRipple(
                color: Color(GreenyBarid),
                size: 2 * screenSize.width / 3,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      map[language]['locate'],
                      textAlign: TextAlign.center,
                      style: titleStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      map[language]['wait'],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          );
  }