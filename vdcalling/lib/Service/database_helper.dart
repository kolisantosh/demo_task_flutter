import 'dart:convert';
import 'dart:io';
import 'package:vdcalling/Service/AppConstant.dart';
import 'package:vdcalling/VideoCalling/Notification.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

class DatabaseHelper {

  static Future<int>notification(Notifier notifier)async{
    var url=Uri.parse("https://fcm.googleapis.com/fcm/send");
    var header={"Content-Type":"application/json","Authorization":"key="+Constant.Server_KEY};
    Response response= await http.post(url,body: jsonEncode(notifier.toJson()),
        headers: header);
    var jsonResponse= jsonDecode(response.body);
    print("resp"+jsonResponse.toString().toString());
    if(jsonResponse!=null){
      print("Notification sent");
    }else {
      print("something went wrong");
    }
    return jsonResponse["success"];
  }

}