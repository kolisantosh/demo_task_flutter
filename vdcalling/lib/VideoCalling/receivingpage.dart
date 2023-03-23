
import 'package:vdcalling/Service/AppConstant.dart';
import 'package:vdcalling/VideoCalling/Notification.dart';
import 'package:vdcalling/VideoCalling/VideoConstant.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdcalling/VideoCalling/Notification.dart';

class ReciverPage extends StatefulWidget {

  String? ptoken;
  String? RoomId;
  String? pname;
  ReciverPage({this.ptoken,this.RoomId,this.pname});

  @override
  _ReciverPageState createState() => _ReciverPageState();
}

class _ReciverPageState extends State<ReciverPage> {
  Notifier? notifier;
  late AudioPlayer audioPlayer;
  @override
  void initState() {
    VideoConstant.iniTialize();
    audioPlayer=new AudioPlayer();
    audioPlayer.setAsset("audio/ring.mp3");
    // audioPlayer.setClip(start: Duration(seconds: 0),end: Duration(seconds: 60));
    audioPlayer.play();
    // TODO: implement initState
    print('Doctor Token_id ${widget.ptoken} , Doctor Room ID ${widget.RoomId}');
    super.initState();
    getData();
  }
  SharedPreferences? pref;
  getData() async {
     pref= await SharedPreferences.getInstance();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(elevation: 0,
      //   leading: SizedBox(),),
      body: Container(
        color: Colors.blue,
        child: InkWell(
            onTap: (){
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: Column(
              children: [
                SizedBox(height: 90,),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network("https://www.pinclipart.com/picdir/middle/355-3553881_stockvader-predicted-adig-user-profile-icon-png-clipart.png",
                      fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(height: 40,),
                Text(widget.pname!,style: TextStyle(fontSize: 20),),
                // Text('Getting Call',style: TextStyle(fontSize: 15),),
                SizedBox(height: 110,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 25,),
                    InkWell(
                      onTap: ()async{
                        if( VideoConstant.sendCancelNotification("${widget.ptoken}",'RoomID2021',Constant.name,pref!.getString("token"),"accept")!=null){
                         if(VideoConstant.acceptyResponseType=="accept"){
                           await VideoConstant.joinMeeting('RoomID2021', Constant.name,widget.ptoken!);
                           print('Doctor Token_id ${widget.ptoken} , Doctor Room ID ${widget.RoomId}');
                           audioPlayer.stop();
                           Navigator.pop(context);
                           // Navigator.pop(context);
                         }
                        }

                      },
                      child: Container(
                          height: 75,width: 75,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(37.5)
                          ),
                          child: Text('Accept',style: TextStyle(
                              color: Colors.white
                          ),)),
                    ),
                    SizedBox(width: 80,),
                    InkWell(
                      onTap: () {
                        VideoConstant.sendCancelNotification("${widget.ptoken}","${widget.RoomId}",pref!.getString("token"),Constant.name,"reject");
                        setState(() {
                          print('Doctor Token_id ${widget.ptoken} , Doctor Room ID ${widget.RoomId}');
                          audioPlayer.stop();
                          Navigator.pop(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>(MyApp1())));
                        });
                      },
                      child: Container(
                          height: 75,width: 75,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(37.5)
                          ),
                          child: Text('Reject',style: TextStyle(
                              color: Colors.white
                          ),)),
                    ),
                    SizedBox(width: 25,),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    print('SamplePage Called Dispose Method');
    audioPlayer.stop();
    // TODO: implement dispose
    super.dispose();
  }


}

