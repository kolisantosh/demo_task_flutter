import 'dart:async';

import 'package:attendancewithqr/model/report.dart';
import 'package:attendancewithqr/utils/strings.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/db_helper.dart';
import '../model/settings.dart';
import '../utils/utils.dart';

class AttendancePage extends StatefulWidget {
  final String query;
  final String title;

  AttendancePage({this.query, this.title});

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  // Progress dialog
  ProgressDialog pr;

  // Database
  DbHelper dbHelper = DbHelper();

  // Utils
  Utils utils = Utils();

  // Model settings
  Settings settings;

  // Global key scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // String
  String getUrl,
      getKey,
      _barcode = "",
      getQrId,
      getQuery,
      getPath = 'api/report/apiSaveReport';

  int getId;

  @override
  void initState() {
    super.initState();
    getSettings();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      getId = preferences.getInt("id");
    });
  }

  // Get settings data
  void getSettings() async {
    var getSettings = await dbHelper.getSettings(1);
    setState(() {
      getUrl = getSettings.url;
      getKey = getSettings.key;
    });
  }

  // Send data post via http
  sendData() async {
    // Get info for reports
    var dataKey = getKey;
    var dataQrId = getQrId;
    var dataQuery = getQuery;

    // Add data to map
    Map<String, dynamic> body = {
      'user_id': getId,
      'qr_id': dataQrId,
      'key': dataKey,
      'q': dataQuery,
    };

    // Sending the data to server
    final uri = utils.getRealUrl(getUrl, getPath);
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap(body);
    final response = await dio.post(uri, data: formData);

    var data = response.data;
    print("+++++++++++++data "+data.toString());

    // Show response from server via snackBar
    if (data['message'] == 'Success!') {
      // Set the url and key
      Report report = Report(
          date: data['date'],
          time: data['time'],
          location: data['location'],
          type: data['query']);

      // Insert the settings
      insertToReportDB(report);

      // Hide the loading
      Future.delayed(Duration(seconds: 2)).then((value) {
        if (mounted) {
          setState(() {
            pr.hide();

            utils.showAlertDialogActionMainMenu(
                "$report_show_alert-$dataQuery $report_success_ms",
                "Success",
                AlertType.success,
                _scaffoldKey);
          });
        }
      });
    } else if (data['message'] == 'already check-in') {
      setState(() {
        pr.hide();

        utils.showAlertDialog(
            already_check_in, "warning", AlertType.warning, _scaffoldKey, true);
      });
    } else if (data['message'] == 'check-in first') {
      setState(() {
        pr.hide();

        utils.showAlertDialog(
            check_in_first, "warning", AlertType.warning, _scaffoldKey, true);
      });
    } else if (data['message'] == 'Error Qr!') {
      setState(() {
        pr.hide();

        utils.showAlertDialog(
            format_barcode_wrong, "Error", AlertType.error, _scaffoldKey, true);
      });
    } else if (data['message'] == 'Error! Something Went Wrong!') {
      setState(() {
        pr.hide();

        utils.showAlertDialog(
            report_error_server, "Error", AlertType.error, _scaffoldKey, true);
      });
    } else {
      setState(() {
        pr.hide();

        utils.showAlertDialog(response.data.toString(), "Error",
            AlertType.error, _scaffoldKey, true);
      });
    }
  }

  insertToReportDB(Report object) async {
    await dbHelper.newReports(object);
  }

  // Scan the QR name of user
  Future scan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      // The value of Qr Code

      if (barcode != null && barcode != '') {
        // Decode the json data form QR
        setState(() {
          // Show dialog
          pr.show();

          // Get name from QR
          getQrId = barcode;
          // Sending the data
          sendData();
        });
      } else {
        utils.showAlertDialog(
            '$barcode_empty', "Error", AlertType.error, _scaffoldKey, true);
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        _barcode = '$camera_permission';
        utils.showAlertDialog(
            _barcode, "Warning", AlertType.warning, _scaffoldKey, true);
      } else {
        _barcode = '$barcode_unknown_error $e';
        utils.showAlertDialog(
            _barcode, "Error", AlertType.error, _scaffoldKey, true);
      }
    } catch (e) {
      _barcode = '$barcode_unknown_error : $e';
      print(_barcode);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show progress
    pr = new ProgressDialog(context,
        isDismissible: false, type: ProgressDialogType.Normal);
    // Style progress
    pr.style(
        message: report_sending,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        padding: EdgeInsets.all(10.0),
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    // Init the query
    getQuery = widget.query;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 60.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(button_scan),
                  color: Color(0xFFf7c846),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  textColor: Colors.black,
                  onPressed: () => scan(),
                ),
              ),
            ),
            Text(
              '$report_button_info-$getQuery.',
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
