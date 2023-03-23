import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:multilanguage/LacaleString.dart';
import 'package:translator/translator.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: Locale('en', 'US'),
      title: 'Multi Language',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Multi Language'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US'), 'val': false},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN'), 'val': true},
  ];
  final translator = GoogleTranslator();
  bool val = true;
  String? result1 = "";

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          print(locale[index]['name']);
                          updateLanguage(locale[index]['locale']);
                          setState(() {
                            val = locale[index]['val'];
                            translations("hello", val);
                          });
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              result1!,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'hello'.tr,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'message'.tr,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'subscribe'.tr,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                buildLanguageDialog(context);
              },
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                child: Text(
                  'changelang'.tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  translations(String input, bool val) async {
    final translator = GoogleTranslator();

    if (val) {
      translator.translate(input, to: 'hi').then((result) {
        setState(() {
          result1 = result.text;
        });
      });
    } else {
      translator.translate(input, to: 'en').then((result) {
        setState(() {
          result1 = result.text;
        });
      });
    }
  }
}

void main() async {
  runApp(MyApp());
}
