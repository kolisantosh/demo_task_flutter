import 'package:attendancewithqr/screen/about_page.dart';
import 'package:attendancewithqr/screen/attendance_page.dart';
import 'package:attendancewithqr/screen/report_page.dart';
import 'package:attendancewithqr/screen/setting_page.dart';
import 'package:attendancewithqr/utils/single_menu.dart';
import 'package:attendancewithqr/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Menu();
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    _getPermission();
    super.initState();
  }

  void _getPermission() async {
    getPermissionAttendance();
  }

  void getPermissionAttendance() async {
    await [
      Permission.camera,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(bottom: 40.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 200.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/logo.png'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        main_menu_title,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SingleMenu(
                      icon: FontAwesomeIcons.clock,
                      menuName: main_menu_check_in,
                      color: Colors.blue,
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AttendancePage(
                            query: 'in',
                            title: main_menu_check_in_title,
                          ),
                        ),
                      ),
                    ),
                    SingleMenu(
                      icon: FontAwesomeIcons.signOutAlt,
                      menuName: main_menu_check_out,
                      color: Colors.blue,
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AttendancePage(
                            query: 'out',
                            title: main_menu_check_out_title,
                          ),
                        ),
                      ),
                    ),
                    SingleMenu(
                      icon: FontAwesomeIcons.cogs,
                      menuName: main_menu_settings,
                      color: Colors.blue,
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SingleMenu(
                      icon: FontAwesomeIcons.calendar,
                      menuName: main_menu_report,
                      color: Colors.blue,
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ReportPage()),
                      ),
                    ),
                    SingleMenu(
                      icon: FontAwesomeIcons.userAlt,
                      menuName: main_menu_about,
                      color: Colors.blue,
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AboutPage()),
                      ),
                    ),
                    SingleMenu(
                        icon: FontAwesomeIcons.info,
                        menuName: 'v 1.0',
                        color: Colors.blue),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
