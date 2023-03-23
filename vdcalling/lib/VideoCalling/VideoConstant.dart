import 'dart:io';
import 'package:vdcalling/Service/database_helper.dart';
import 'package:vdcalling/VideoCalling/Notification.dart';
import 'package:vdcalling/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';

class VideoConstant{
  static BuildContext? context;
  static final String meetingType="video";
  static final String token="Token";
  static final String acceptyResponseType="accept";
  static final String rejectResponseType="reject";
  static String responseType="";


  static final iosAppBarRGBAColor =
   TextEditingController(text: "#0080FF80"); //transparent blue
  static bool isAudioOnly = true;
  static bool isAudioMuted = true;
  static bool isVideoMuted = true;


   static iniTialize(){
     JitsiMeet.addListener(JitsiMeetingListener(
         onConferenceWillJoin: _onConferenceWillJoin,
         onConferenceJoined: _onConferenceJoined,
         onConferenceTerminated: _onConferenceTerminated,
         onError: _onError));


  }

  static void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  static void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  static void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  static String sendNotification(String patientTokenId,String patientRoomId,String doctorName,String doctorTokenId, String responseType){
    DatabaseHelper.notification(
        Notifier(
        to: patientTokenId,
        notification: Notifications(
        body: "Answer the Call",
        title:"User Calling", sound: doctorTokenId,
          tag: responseType, color: '',
        ),
            data: Datas(room_id: patientRoomId,name:doctorName,token: doctorTokenId,tag: responseType,))).then((value){
      if(value!=0){
        // notifyReceiver();
        print("data post successfully:");
      }
    });
    return patientTokenId;
  }
  static String sendCancelNotification(String patientTokenId,String patientRoomId,String doctorName,String doctorTokenId, String responseType){
    DatabaseHelper.notification(
        Notifier(
        to: patientTokenId,
        notification: Notifications(
        body: "Call Cancelled",
        title:'User', sound: doctorTokenId,
          tag: responseType, color: '',
        ),
            data: Datas(room_id: patientRoomId,name:doctorName,token: doctorTokenId,tag: responseType,))).then((value){
      if(value!=0){
        // notifyReceiver();
        print("data post successfully:");
      }
    });
    return patientTokenId;
  }


   static cancelmeeting()async{
    // FirebaseMessaging.instance;
    // FirebaseMessaging.onMessage.listen((event) {
    //   if(event.notification.android.tag=="reject"){
    //     Fluttertoast.showToast(
    //         msg: "Patient Disconnected",
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 3,
    //         backgroundColor: Colors.black45,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
       Navigator.push(context!, MaterialPageRoute(builder: (context)=>(MyApp())));
    //     print("Hello");
    //   }
    // });
    await JitsiMeet.removeAllListeners();
  }


  static joinMeeting(String roomid,String name,String doctorTokenId) async {
    // String serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;
    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: roomid)
    // ..serverURL = serverUrl
    // ..subject = subjectText.text
      ..userDisplayName = name
    // ..userEmail = emailText.text
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomid,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": name}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
            // if(sendNotification(doctorTokenId,null,null,"",responseType) != null){
            //   cancelmeeting();
            // }

            cancelmeeting();
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
  customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
          .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };


  static  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}

