import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:qibladirection/AppConstant.dart';
import 'package:qibladirection/consts.dart';
import 'package:qibladirection/widgetLoadingPos.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:async';
import 'dart:math';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QiblahCompass(language: 2),
    );
  }
}

class QiblahCompass extends StatelessWidget {
  bool _msgVisibility = true;
  final language;

  QiblahCompass({this.language});

  hideMsg() async {
    await new Future.delayed(const Duration(seconds: 10));
    _msgVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    hideMsg();
    return Scaffold(
        backgroundColor: AppColors.tela1,
        appBar: AppBar(
          title: Container(
              height: 40,
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Center(
                // padding: EdgeInsets.only(top: 3),
                child: Text(
                  "Qibla",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.Appname,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto"),
                ),
              )),
          elevation: 0.0,
          backgroundColor: AppColors.tela2,
//                backgroundColor: Colors.blue,
//           leading: IconButton(
//             onPressed: () {
//               // Navigator.push(
//               //     context, MaterialPageRoute(builder: (context) => MyApp1()));
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: AppColors.white,
//             ),
//           ),

          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 5, right: 5),
              child: FlutterLogo()
            ),
          ],
        ),
        body: Container(
            height: screenSize.height,
            width: screenSize.width,
            color: AppColors.tela11,
            // alignment: Alignment.center,
            child: Stack(children: <Widget>[
              Container(
                // alignment: Alignment.bottomCenter,
                width: screenSize.width,
                height: screenSize.height,
                child: Image.asset("assets/images/qiblahbg.png",fit: BoxFit.fill,),
              ),
              StreamBuilder(
                stream: FlutterQiblah.qiblahStream,
                builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return WidgetLoadingPos(language, screenSize);

                  final qiblahDirection = snapshot.data;

                  return qiblahDirection != null
                      ? Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /* Visibility(
                            visible: _msgVisibility == true,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                compass[language]['msg'],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),*/

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: (language == AR)
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        children: <Widget>[
                          /* Text(
                                compass[language]['qiblah'],
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                "${qiblahDirection.offset.toStringAsFixed(1)}°",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                    fontSize: 25),
                              ),*/
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        width:screenSize.width,
                        height:screenSize.height/2-50,
                        child: Stack(
                          children: [
                            _buildCompass(),
                            Container(
                              padding: EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              child: Transform.rotate(
                                angle: ((qiblahDirection.qiblah ??
                                    0) *
                                    (pi / 180) *
                                    -1),
                                alignment: Alignment.center,
                                child: Image.asset(
                                    'assets/images/Qiblah.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : WidgetLoadingPos(language, screenSize);
                },
              ),
            ])
        )


    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        double direction = snapshot.data.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null)
          return Center(
            child: Text("Device does not have sensors !"),
          );

        return Material(
          shape: CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            color: AppColors.tela1,
            /*decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),*/
            child: Transform.rotate(
              angle: (direction * (math.pi / 180) * -1),
              child: Image.asset('assets/images/compass.png'),
            ),
          ),
        );
      },
    );
  }
}
