import 'dart:ui';

import 'package:alarm/AppConstant.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Alarm/alarm_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DisableBatteryOptimization.showDisableBatteryOptimizationSettings();


  AwesomeNotifications().initialize(
    'resource://drawable/logo',
    [
      NotificationChannel(
        icon: 'resource://drawable/logo',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        playSound: true,
        soundSource: 'resource://raw/chronos_alarm',
        defaultColor: AppColors.tela,
        vibrationPattern: lowVibrationPattern,
        importance: NotificationImportance.High,
        ledColor: AppColors.tela,
      ),
      NotificationChannel(
          icon: 'resource://drawable/logo',
          channelKey: 'scheduled',
          channelName: 'Scheduled notifications',
          channelDescription: 'Notifications with schedule functionality',
          playSound: true,
          soundSource: 'resource://raw/chronos_alarm',
          defaultColor: AppColors.tela,
          ledColor: AppColors.tela,
          vibrationPattern: lowVibrationPattern,
          importance: NotificationImportance.High,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Alarm),
    ],
    // debug: true
  );
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  runApp(MyApp());
}

Future<void> repeatMinuteNotification(ReceivedAction receivedAction) async {

  String localTimeZone = (DateTime.now().timeZoneOffset.inHours).toString();

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: receivedAction.id,
          channelKey: 'scheduled',
          title: receivedAction.title,
          body: receivedAction.body,
          payload: receivedAction.payload
        // notificationLayout: NotificationLayout.BigPicture,
        // bigPicture: 'asset://assets/images/melted-clock.png'
      ),
      actionButtons: [
        NotificationActionButton(
            key: 'Snooze', label: 'Snooze', autoCancel: false),
        NotificationActionButton(key: 'Stop', label: 'Stop', autoCancel: false)
      ],
      schedule: NotificationInterval(
          interval: 60, timeZone: localTimeZone, repeats: true)
  );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlarmPage(),
    );
  }
}