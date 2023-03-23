import 'package:vdcalling/Login.dart';
import 'package:vdcalling/SignUp.dart';
import 'package:vdcalling/Start.dart';
import 'package:vdcalling/VideoCalling/receivingpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'VideoCalling/RingPage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onGetnoti();
  }

  void onGetnoti() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      AndroidNotification? android = message!.notification!.android;
      if (message.notification!.title != null) {
        setState(() async {
          var doctorRoomId = message.data.values.last.toString();
          var name = message.data.values.first.toString();
          var doctorTokenId = message.notification!.android!.sound;
          if (message.notification!.android!.tag == 'accept') {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => (ReciverPage(
                        ptoken: doctorTokenId,
                        RoomId: doctorRoomId,
                        pname: name))));

          } else if (message.notification!.android!.tag == "reject") {
          }
          print("Doctor TokenId:" + doctorTokenId!);
          // print("response" + message.notification!.android!.tag.toString());
          print("Doctor RoomId:" + doctorRoomId);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "start": (BuildContext context) => Start(),
      },
    );
  }
}
