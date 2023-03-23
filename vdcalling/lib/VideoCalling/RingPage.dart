
import 'package:vdcalling/Service/AppConstant.dart';
import 'package:vdcalling/VideoCalling/VideoConstant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RingPage extends StatefulWidget {
  // String patientToken;
  // String roomid;
  // String username;
  Map<String,dynamic> user;

  // RingPage(this.patientToken,this.roomid,this.username);
  RingPage(this.user);

  @override
  _RingPageState createState() => _RingPageState();
}

class _RingPageState extends State<RingPage> {
  // AudioPlayer advancedPlayer;
  // AudioCache audioCache;
  bool notification = false;
  // List<ListModel> sliderlist;

  final FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    VideoConstant.iniTialize();
    super.initState();
    // getShopListby(widget.mv).then((usersFromServe1) {
    //   setState(() {
    //     sliderlist = usersFromServe1;
    //     // Constant.contact=sliderlist.mobileNo;
    //     if(sliderlist!=null&&sliderlist.length>0)
          getData();
    //   });
    // });
  }
  late SharedPreferences pref;
  getData() async {
    pref= await SharedPreferences.getInstance();
    getToken();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserNotification() == false
          ? Container(
                  // color: Colors.blue,
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   fit: BoxFit.cover,
                    //   image: AssetImage('assets/images/5.jpeg',),
                    // ),
                    gradient: LinearGradient(
                        colors: [AppColors.boxColor2, AppColors.boxColor1]),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 70),
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBcaUhNQfR1D2a7vObjklLD_5unG8POsCzkcUqrLXn4ivlOczXqHU7X4-dSlTT-_EK4wY&usqp=CAU",
                            // Constant.logo_Image_mv + sliderlist[0].pp,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                          widget.user['name'],
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Calling...",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      GestureDetector(
                        onTap: () {

                          VideoConstant.sendCancelNotification(
                              widget.user['token'],
                              'RoomID2021',
                              Constant.name,
                              pref.getString("token"),
                              "reject");

                          // audioPlayer.stop();
                          // print('User Name : ${sliderlist[0].name}');
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 70),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(40)),
                          child: Icon(
                            Icons.clear,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
          : Container(),
    );
  }

  openingActions() async {
    //add this
    // player = await cache.loop('assets/welcome.mp3'); //add this
    // audioCache.play("audio/ring.wav");
    // audioCache.play("audio/ring.mp3");
  }


  bool UserNotification(){
    FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      // print('Patient RoomId'+message!.notification.android!.sound);
      if( message!.notification!.title!=null){
        if(this.mounted) {
          setState(() {
            var noti= message.notification!.title.toString();
            print("noti:"+noti);
            if(message.notification!.android!.tag=="accept"){
              setState(() {
                UserNotification()==true;
              });
              Fluttertoast.showToast(
                  msg: noti,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.black45,
                  textColor: Colors.white,
                  fontSize: 16.0);
              //audioPlayer.setAsset("sound/noti.mp3");
              //audioPlayer.setClip(start: Duration(seconds: 0),end: Duration(seconds: 60));
              VideoConstant.joinMeeting('RoomID2021' ,Constant.name,widget.user['token']);
              // VideoConstant.joinMeeting('RoomID2021' + sliderlist[0].mvId,
              //                       Constant.username, sliderlist[0].firebase);
              // audioPlayer.stop();
              Navigator.pop(context);
            }else if(message.notification!.android!.tag=="reject"){
              Fluttertoast.showToast(
                  msg: 'Rejected',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.black45,
                  textColor: Colors.white,
                  fontSize: 16.0);
              // audioPlayer.stop();
              Navigator.pop(context);
            }
            var receivername=   message.data.values.last.toString();
            print('Receiver Name ${receivername}');
          });
        }
      }
    });
    return notification;
  }

  var token;
  Future<String> getToken()async{
    token=await _firebaseMessaging.getToken();
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('TokenId', token);
    setState(() {
      Constant.newTokenId=pref.getString('TokenId');
      VideoConstant.sendNotification(
          widget.user['token'],
          'RoomID2021',
          Constant.name,
          token,
          "accept");
    });
    // print("tokenId Saved: "+AppConstant.newTokenId);
    return token;

  }
}
