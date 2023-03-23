import 'dart:ui';

import 'package:alarm/AppConstant.dart';
import 'package:alarm/components/theme_data.dart';
import 'package:alarm/main.dart';
import 'package:alarm/model/alarm_info.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'package:awesome_notifications/awesome_notifications.dart'
    hide DateUtils;

import 'alarm_helper.dart';
import 'alarmcount.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late DateTime _alarmTime;
  late String repeat = "", _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  late List<AlarmInfo> _currentAlarms;
  final nameController = TextEditingController();
  final renoController = TextEditingController();
  bool ason = true;
  int notid = 0;
  int colorno = 0;

  List<bool> _listItem1 = [
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  @override
  void initState() {
    try {
      AwesomeNotifications().createdStream.listen((receivedNotification) {
        String? createdSourceText =
            AssertUtils.toSimpleEnumString(receivedNotification.createdSource);
      });

      AwesomeNotifications().displayedStream.listen((receivedNotification) {
        String? createdSourceText =
            AssertUtils.toSimpleEnumString(receivedNotification.createdSource);
      });

      AwesomeNotifications().dismissedStream.listen((receivedNotification) {
        String? dismissedSourceText = AssertUtils.toSimpleEnumString(
            receivedNotification.dismissedLifeCycle);
      });

      AwesomeNotifications().actionStream.listen((receivedNotification) {
        if (!StringUtils.isNullOrEmpty(receivedNotification.buttonKeyInput)) {
        } else if (!StringUtils.isNullOrEmpty(
                receivedNotification.buttonKeyPressed) &&
            receivedNotification.buttonKeyPressed.startsWith('MEDIA_')) {
        } else {
          processDefaultActionReceived(receivedNotification);
        }
      });

      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        setState(() {
          notificationsAllowed = isAllowed;
        });

        if (!isAllowed) {
          requestUserPermission(isAllowed);
        }
      });
    } catch (Exception) {}
    nameController.text = 'alarm';
    renoController.text = "1";

    _alarmTime = DateTime.now();
    print(_alarmTime.hour + _alarmTime.minute + _alarmTime.second);
    print('------database intialized ' + _alarmTime.toString());

    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  int armmnt = 00;
  int armhours = 00;
  int armsecond = 00;

  int chngmnt = 00;
  int chnghours = 00;
  int chngsecond = 00;
  bool notificationsAllowed = false;

  void requestUserPermission(bool isAllowed) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Color(0xfffbfbfb),
        title: Text('Get Notified!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/animated-bell.gif',
              height: 200,
              fit: BoxFit.fitWidth,
            ),
            Text(
              'Allow Notifications to send you beautiful notifications!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.grey),
            onPressed: () async {
              Navigator.of(context).pop();
              notificationsAllowed =
                  await AwesomeNotifications().isNotificationAllowed();
              setState(() {
                notificationsAllowed = notificationsAllowed;
              });
            },
            child: Text('Later', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: AppColors.tela),
            onPressed: () async {
              Navigator.of(context).pop();
              await AwesomeNotifications()
                  .requestPermissionToSendNotifications();
              notificationsAllowed =
                  await AwesomeNotifications().isNotificationAllowed();
              setState(() {
                notificationsAllowed = notificationsAllowed;
              });
            },
            child: Text('Allow', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms().whenComplete(() => setState(() {}));
  }

  void processDefaultActionReceived(ReceivedAction receivedNotification) {
    // Avoid to reopen the media page if is already opened
    if (receivedNotification.channelKey == 'media_player') {
    } else if (receivedNotification.channelKey == 'scheduled') {
      if (receivedNotification.buttonKeyPressed == 'Snooze') {
        print("_repeatNotification Start");
        repeatMinuteNotification(receivedNotification);
      } else {
        AwesomeNotifications().cancel(receivedNotification.id as int);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AlarmCount(receivedNotification, receivedNotification.id)),
        );
      }
    } else if (receivedNotification.buttonKeyPressed == 'Snooze') {
      repeatMinuteNotification(receivedNotification);
    } else {
      AwesomeNotifications().cancel(receivedNotification.id as int);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    AwesomeNotifications().cancel(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Container(
            height: 40,
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
              // padding: EdgeInsets.only(top: 3),
              child: Text(
                "Alarm",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.Appname,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto"),
              ),
            )),
        elevation: 0.0,
        backgroundColor: AppColors.tela,
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<AlarmInfo>>(
                future: _alarms,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _currentAlarms = snapshot.data!;
                    return ListView(
                      children: snapshot.data!.map<Widget>((alarm) {
                        print(alarm.id);
                        var alarmTime = DateFormat('hh:mm aa')
                            .format(alarm.alarmDateTime as DateTime);
                        var gradientColor = GradientTemplate
                            .gradientTemplate[alarm.gradientColorIndex as int]
                            .colors;

                        return Container(
                          // height: _size.height/9,
                          margin: const EdgeInsets.only(bottom: 2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColor,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: gradientColor.last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.label,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    alarm.title!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  ),
                                  Switch(
                                    onChanged: (bool value) {
                                      setState(() {
                                        _listItem1[alarm.gradientColorIndex!] =
                                            value;
                                        value
                                            ? flutterLocalNotificationsPlugin
                                                .cancel(alarm.id!)
                                            : null;
                                      });
                                    },
                                    value:
                                        _listItem1[alarm.gradientColorIndex!],
                                    activeColor: Colors.white,
                                  ),
                                ],
                              ),
                              Container(),
                              Text(
                                // 'Every Day',
                                'Mon-Fri',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'avenir'),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    alarmTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.white,
                                      onPressed: () {
                                        // deleteAlarm(alarm);
                                        deleteAlarm(context, alarm);
                                        // _deleteAlarm(alarm.alarmDateTime,alarm);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return Center(
                    child: Text(
                      'Loading..',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
          showModalBottomSheet(
            useRootNavigator: true,
            context: context,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Container(
                    height: _size.height / 2,
                    padding: const EdgeInsets.all(32),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FlatButton(
                            onPressed: () async {
                              var selectedTime = await showTimePicker(
                                context: context,
                                initialEntryMode: TimePickerEntryMode.input,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                final now = DateTime.now();
                                var selectedDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    selectedTime.hour,
                                    selectedTime.minute);
                                _alarmTime = selectedDateTime;
                                setModalState(() {
                                  _alarmTimeString = DateFormat('HH:mm')
                                      .format(selectedDateTime);
                                });
                              }
                            },
                            child: Text(
                              _alarmTimeString,
                              style: TextStyle(fontSize: 32),
                            ),
                          ),
                          ListTile(
                            title: Text(nameController.text != ""
                                ? nameController.text
                                : 'Title'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              _showDialogEdit();
                            },
                          ),
                          FloatingActionButton.extended(
                            onPressed: onSaveAlarm,
                            backgroundColor: AppColors.tela,
                            icon: Icon(Icons.alarm),
                            label: Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
          // scheduleAlarm();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showNotificationWithActionButtons(int id) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'basic_channel',
            title: 'Alarm',
            body: 'wack up from complete muslim',
            payload: {'uuid': 'user-profile-uuid'}),
        actionButtons: [
          NotificationActionButton(
              key: 'Snooze', label: 'Snooze', autoCancel: true),
          NotificationActionButton(key: 'Stop', label: 'Stop', autoCancel: true)
        ]);
  }

  Future<void> showNotificationAtScheduleCron(
      AlarmInfo alarmInfo, DateTime scheduleTime) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: alarmInfo.notid,
            channelKey: 'scheduled',
            title: Constant.appname,
            body: alarmInfo.title,
            // notificationLayout: NotificationLayout.BigPicture,
            // bigPicture: 'asset://assets/images/delivery.jpeg',
            payload: {'repeat': alarmInfo.repeat.toString()},
            autoCancel: false),
        actionButtons: [
          NotificationActionButton(
              key: 'Snooze', label: 'Snooze', autoCancel: true),
          NotificationActionButton(
            key: 'Stop',
            label: 'Stop',
            autoCancel: false,
          )
        ],
        schedule: NotificationCalendar.fromDate(date: scheduleTime));
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
          NotificationActionButton(
              key: 'Stop', label: 'Stop', autoCancel: false)
        ],
        schedule: NotificationInterval(
            interval: 60, timeZone: localTimeZone, repeats: true));
  }

  Future<void> cancelScheduledAlarm(context, id, isCancelled) async {
    // cancel the notification with id value of zero
    await flutterLocalNotificationsPlugin.cancel(id);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        isCancelled
            ? "You Alarm has been Cancelled!"
            : "You Alarm has been Deleted!",
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.grey,
    ));
  }

  void scheduleAlarm(DateTime scheduledNotificationDateTime,
      AlarmInfo alarmInfo, int noti_id) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'logo',
      sound: RawResourceAndroidNotificationSound('chronos_alarm'),
      largeIcon: DrawableResourceAndroidBitmap('logo'),
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      fullScreenIntent: true,
    );
    print(scheduledNotificationDateTime);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'chronos_alarm.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    print(scheduledNotificationDateTime.hour.toString() +
        "++++++" +
        scheduledNotificationDateTime.minute.toString());
    var time = Time(scheduledNotificationDateTime.hour,
        scheduledNotificationDateTime.minute, 0);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      noti_id,
      Constant.appname,
      nameController.text,
      time,
      platformChannelSpecifics,
      payload: alarmInfo.repeat.toString(),
    );
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));
    print(scheduleAlarmDateTime.toString());

    notid++;
    print("notid $notid");

    print("colorno ${colorno}");

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: colorno,
      title: nameController.text,
      repeat: int.parse(renoController.text),
      notid: notid,
    );

    int nid;
    _alarmHelper.insertAlarm(alarmInfo).then((id) => {
          print('Added to Db ${id}'),
          nid = id,
          showNotificationAtScheduleCron(alarmInfo, scheduleAlarmDateTime)
        });

    Navigator.pop(context);
    loadAlarms();
    nameController.text = "alarm";
  }

  Future<void> deleteAlarm(context, AlarmInfo alarmInfo) async {
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.notid!);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "You Alarm has been Deleted!",
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black,
    ));

    _alarmHelper.delete(alarmInfo.id as int);

    loadAlarms();
  }

  _showDialogEdit() async {
    await showDialog<String>(
      context: context,
      builder: (_) => new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Container(
          height: 100,
          child: Column(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Alarm Title";
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Alarm Title"),
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                if (nameController.text != "") {
                  Navigator.pop(context);
                } else {
                  // showLongToast("Please Field Data");
                }
              })
        ],
      ),
    );
  }
}
