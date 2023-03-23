import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vdcalling/Service/AppConstant.dart';
import 'package:vdcalling/VideoCalling/RingPage.dart';
import 'package:vdcalling/VideoCalling/receivingpage.dart';
import 'package:vdcalling/models/usersModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final database = FirebaseDatabase.instance.reference();

  User? user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;
    var token = await _firebaseMessaging.getToken();

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;

        Constant.name=user!.displayName!;
        Constant.email=user!.email!;
        this.isloggedin = true;
        final dailySpecialRef = database.child("vdcalling/users");
        print("" + token!);
        // dailySpecialRef
        //     .set({
        //       'name': user!.displayName,
        //       'mobile': '1234567890',
        //       'email': user!.email,
        //       'token': token
        //     })
        //     .then((value) => print("Successful......"))
        //     .onError((error, stackTrace) => print("Error................"));

        // dailySpecialRef.child('mobile').set('1234567890')
        //     .then((value) => print("Successful......"))
        //     .onError((error, stackTrace) => print("Error................"));
        // dailySpecialRef.push().update({
        //   'name': user!.displayName,
        //   'mobile': '1234567890',
        //   'email': user!.email,
        //   'token': token
        // });

     /*   dailySpecialRef.push().set({
          'name': user!.displayName,
          'mobile': '1234567890',
          'email': user!.email,
          'token': token
        });*/
      });
    }
  }

  signOut() async {
    _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();

    onGetnoti();
  }

  void onGetnoti() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      AndroidNotification? android = message!.notification!.android;
      if (message.notification!.title != null) {
        setState(() async {
          //  Constant.responseType=message.notification.android.tag;


          // await flutterLocalNotificationsPlugin!.show(
          //     0,
          //     message.notification!.title,
          //     message.notification!.body,
          //     platformChannelSpecifics,
          //     payload: '${ message.notification!.body}');

          var doctorRoomId = message.data.values.last.toString();
          var name = message.data.values.first.toString();
          var doctorTokenId = message.notification!.android!.sound;
          // notificationCounterValueNotifer.value++;
          // notificationCounterValueNotifer.notifyListeners();
          if (message.notification!.android!.tag == 'accept') {
            // FlutterWebviewPlugin().hide();
            // FlutterWebviewPlugin().show();
            print("response2 " + message.notification!.android!.tag.toString()+'\n'+ message.notification!.android!.sound.toString()+'\n'+ message.data!.values.last.toString()+ '\n'+message.data!.values!.first.toString());
            Fluttertoast.showToast(
                msg: 'Accept',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => (ReciverPage(
                        ptoken: doctorTokenId,
                        RoomId: doctorRoomId,
                        pname: name))));

          } else if (message.notification!.android!.tag == "reject") {
            Fluttertoast.showToast(
                msg: 'Rejected',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 16.0);
            // Navigator.pop(context);
          }
          print("Doctor TokenId:" + doctorTokenId!);
          print("response" + message.notification!.android!.tag.toString());
          print("Doctor RoomId:" + doctorRoomId);
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List",style: TextStyle(color: Colors.white),),
        actions: [
          RaisedButton(
            padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
            onPressed: signOut,
            child: Text('Signout',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: !isloggedin
              ? Center(child: CircularProgressIndicator())
              : ListView(
            children: <Widget>[
              Container(
                child: Text(
                  "Hello ${user!.displayName} you are Logged in as ${user!
                      .email}",
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                  stream: database
                      .child("vdcalling/users")
                      .onValue,
                  builder: (context, snapshot) {
                    final tilelist = <ListTile>[];
                    if (snapshot.hasData) {
                      final getlist = Map<String, dynamic>.from(
                          (snapshot!.data as Event).snapshot!.value);
                      print(getlist.toString());
                      // tilelist.addAll(getlist.values.map((val) {
                      //   final nextuser = UsersModel.fromRTDB(
                      //       Map<String, dynamic>.from(value));
                      getlist.forEach((key, value) {
                        final data = Map<String, dynamic>.from(value);
                        print("+++++++++++++++"+data['name']);
                        final tilel = ListTile(
                            leading: Icon(Icons.person),
                            title: Text(data['name']??"data"),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RingPage(data)));
                              },
                              icon: Icon(Icons.video_call),
                            ));
                        tilelist.add(tilel);
                      });
                    }
                    return Expanded(
                      child: Column(
                        children: tilelist,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { refreshData(); },
        child: IconButton(
          disabledColor: Colors.amberAccent,
          onPressed: () {
            refreshData();
          },
          icon: Icon(Icons.refresh),
        ),
      ),
    );
  }

  refreshData() {
    final dailySpecialRef =
    database
        .child("vdcalling/users")
        .onValue
        .listen((event) {
      setState(() {
        final data = new Map<String, dynamic>.from(event.snapshot.value);
        final userlist = UsersModel.fromRTDB(data);
        print(userlist.toString());
        print(userlist.name);
        print(data['email']);
      });
    });
  }

  refreshData1() {
    final dailySpecialRef =
    database.child("vdcalling/users").once().then((snapshot) {
      setState(() {
        final data = new Map<String, dynamic>.from(snapshot.value);
        final userlist = UsersModel.fromRTDB(data);
        print(userlist.toString());
        print(userlist.name);


      });
    });
  }

}
