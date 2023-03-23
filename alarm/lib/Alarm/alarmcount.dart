import 'dart:async';

import 'package:alarm/Alarm/alarm_page.dart';
import 'package:alarm/main.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slider_button/slider_button.dart';

import '../AppConstant.dart';

class AlarmCount extends StatefulWidget {
  int? id;
  ReceivedAction? receivedAction;
  AlarmCount(this.receivedAction,this.id);

  static const String routeName = '/AlarmCount';

  @override
  _HomePageState createState() => _HomePageState();
}

enum PlayerState { stopped, playing, paused }

class _HomePageState extends State<AlarmCount> {
  int count = 0;
  bool check = true;
  int totalcount = 100;

  final nameController = TextEditingController();
  final mobileController = TextEditingController();


  List<Color> _listcolor = [];
  List<Color> _listcolor1 = [
    Color(0x2BD85757),
    Color(0x406E7D95),
    Color(0x4049E27D),
    Color(0x40D881D4),
    Color(0x40D8BB57),
    Color(0x404595DF),
    Color(0x406F7C1B),
    Color(0x4043BEA1),
  ];

  StreamSubscription? _positionSubscription;
  StreamSubscription? _audioPlayerStateSubscription;
  PlayerState playerState = PlayerState.paused;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer, respectSilence: false);
    _audioPlayerStateSubscription =
        advancedPlayer!.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
      } else if (s == AudioPlayerState.STOPPED) {

      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        musicLength = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });

    openingActions();

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < _listcolor1.length; j++) {
        _listcolor.add(_listcolor1[j]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              children: [
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 0,
                  child: Container(
                    width: _size.width,
                    height: _size.height,
                    decoration: new BoxDecoration(),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pop();
                          AwesomeNotifications().cancel(widget.id as int);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AlarmPage()),
                          );
                        });
                      },
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: _size.height - 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0, left: 18.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${widget.receivedAction!.body}",
                                            style: TextStyle(
                                              fontSize: 35,
                                            ),
                                          )),
                                    ),

                                    Center(
                                        child: SliderButton(
                                          action: () {
                                            ///Do something here OnSlide
                                            print("working");
                                            Navigator.of(context).pop();
                                            repeatMinuteNotification(widget.receivedAction!);
                                          },
                                          ///Put label over here
                                          label: Text(
                                            "Slide to Snooze",
                                            style: TextStyle(
                                                color: Color(0xff4a4a4a),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                          icon: Center(
                                              child: Icon(
                                                Icons.power_settings_new,
                                                color: Colors.white,
                                                size: 40.0,
                                                semanticLabel: 'Text to announce in accessibility modes',
                                              )),

                                          //Put BoxShadow here
                                          boxShadow: BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 4,
                                          ),

                                          //Adjust effects such as shimmer and flag vibration here
                                          // shimmer: true,
                                          // vibrationFlag: true,

                                          ///Change All the color and size from here.
                                          width: 230,
                                          radius: 10,
                                          buttonColor: Color(0xffd60000),
                                          backgroundColor: Color(0xff534bae),
                                          highlightedColor: Colors.white,
                                          baseColor: Colors.red,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (advancedPlayer != null) {
      advancedPlayer!.stop();
      musicLength = Duration(seconds: 0);
      position = Duration(seconds: 0);
      advancedPlayer = null;
    }
    super.dispose();
  }

  AudioPlayer? advancedPlayer;
  AudioCache? audioCache;

  openingActions() async {
    audioCache!.play("audio/chronos_alarm.mp3", stayAwake: true);
  }
}
