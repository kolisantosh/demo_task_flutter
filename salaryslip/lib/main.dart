import 'package:flutter/material.dart';
import 'package:salaryslip/smi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMI Infotech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Smiinfotech(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salary Slip"),
        backgroundColor: Colors.green,
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "SMI Infotech",
            textScaleFactor: 2,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Table(
          // textDirection: TextDirection.rtl,
          // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
          border: TableBorder.all(width: 1.0, color: Colors.grey.shade300),
          children: [
            TableRow(children: [
              Text(
                "<logo>",
                textScaleFactor: 1.5,
              ),
              Text("Pay Advice-",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5),
              Text("Jul", textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
              Text("2021", textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
            ]),
            TableRow(children: [
              Text(" ",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
              Text(" ", textAlign:TextAlign.center,textScaleFactor: 1.5),
              Text(" ", textScaleFactor: 1.5),
              Text(" ",textScaleFactor: 1.5),
            ]), TableRow(children: [
              Text("Employee Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
              Text(":", textAlign:TextAlign.center,textScaleFactor: 1.5),
              Text("Employee Name", textScaleFactor: 1.5),
              Text("SMI INFOTECH" +
                  "243, Royal Square, Nr. Indian Oil Petrol Pump, Nr. VIP Circle, Mota-Varacha, Uttran, Surat - 394105 | Mo. No.: +91 960 153 7800 | E-Mail: info@smiinfotech.com"
                  ,textScaleFactor: 1.5),
            ]),

            TableRow(children: [
              Text("Designation",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
              Text(":", textAlign:TextAlign.center,textScaleFactor: 1.5),
              Text("Sr. Business Development Manager & Branch Manager",
                  textScaleFactor: 1.5),
              Text("", textScaleFactor: 1.5),
            ]),
          ],
        ),
        Table(
            border: TableBorder.all(width: 1.0, color: Colors.grey.shade300),
            children: [
              TableRow(
                children: [
                  Text("Date of Joining",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text(":", textAlign:TextAlign.center,textScaleFactor: 1.5),
                  Text("1-Jul-2021", textScaleFactor: 1.5),
                  Text("Earnings",
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                  Text("Actual",
                      style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.right,textScaleFactor: 1.5),
                  Text("Earned",
                      style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("Deduction",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("Amount",
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                ],
              ),
              TableRow(
                children: [
                  Text("Bank A/C No.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                  Text(":",textAlign:TextAlign.center, textScaleFactor: 1.5),
                  Text("138212786143", textScaleFactor: 1.5),
                  Text("Basic Pay",
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                  Text("18000",textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("18000", textAlign:TextAlign.right,textScaleFactor: 1.5),
                  Text("Provident Fund(PF)",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("0", textScaleFactor: 1.5),
                ],
              ),
              TableRow(
                children: [
                  Text("", textScaleFactor: 1.5),
                  Text("", textScaleFactor: 1.5),
                  Text("ICICI Bank, Rander", textScaleFactor: 1.5),
                  Text("Over Time",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("0", textAlign:TextAlign.right,textScaleFactor: 1.5),
                  Text("0", textAlign:TextAlign.right,textScaleFactor: 1.5),
                  Text("Professional Tax(PT)",
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                  Text("0", textScaleFactor: 1.5),
                ],
              ),
              TableRow(
                children: [
                  Text("Working Day[s]",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text(":",textAlign:TextAlign.center, textScaleFactor: 1.5),
                  Text("31", textScaleFactor: 1.5),
                  Text("Incentive",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("2000",textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("2000",textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("Other Deduction",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("0", textScaleFactor: 1.5),
                ],
              ),
              TableRow(
                children: [
                  Text("Present Day[s]",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text(":", textAlign:TextAlign.center,textScaleFactor: 1.5),
                  Text("31", textScaleFactor: 1.5),
                  Text("PMB",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("0",textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("0",textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("Loan",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("0", textScaleFactor: 1.5),
                ],
              ),
              TableRow(
                children: [
                  Text("Holiday[s]",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                  Text(":",textAlign:TextAlign.center, textScaleFactor: 1.5),
                  Text("0", textScaleFactor: 1.5),
                  Text("Paid leave(PL)",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("0",textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("0",textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("Gross Deduction",
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                  Text("0", textScaleFactor: 1.5),
                ],
              ),
              TableRow(
                children: [
                  Text("SL",
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                  Text(":",textAlign:TextAlign.center, textScaleFactor: 1.5),
                  Text("0", textScaleFactor: 1.5),
                  Text("Gross Total",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("₹20,000",
                      style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("₹20,000",
                      style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.right, textScaleFactor: 1.5),
                  Text("Net Amount",
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                  Text("₹20,000",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                ],
              ),
            ]),
        Table(
            border: TableBorder.all(width: 1.0, color: Colors.grey.shade300),
            children: [
              TableRow(
                children: [
                  Text("CL",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text(":",textAlign:TextAlign.center, textScaleFactor: 1.5),
                  Text("0", textScaleFactor: 1.5),
                  Text("Rupees(₹):",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text("Twenty Thousand Rupees Only", textScaleFactor: 1.5),
                ],
              ),
              TableRow(
                children: [
                  Text("OT ( Hours )",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
                  Text(":",textAlign:TextAlign.center, textScaleFactor: 1.5),
                  Text("0", textScaleFactor: 1.5),
                  Text("Remark[s]:",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5),
                  Text(
                      "Credited ₹10,000 & ₹10,000 in Bank A/C at various days.",
                      textScaleFactor: 1.5),
                ],
              ),
            ]),
        Table(
            border: TableBorder.all(width: 1.0, color: Colors.grey.shade300),
            children: [
              TableRow(
                children: [
                  Text("Date",
                      style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.right,textScaleFactor: 1.5),
                  Text(":", textAlign:TextAlign.center,textScaleFactor: 1.5),
                  Text("11-Aug-2021 & 16-Aug-2021",
                      style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),

                ],
              ),
              TableRow(
                children: [
                  Text("NOTE",
                      style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.right,textScaleFactor: 1.5),
                  Text(":",textAlign:TextAlign.center, textScaleFactor: 1.5),
                  Text("This is a computer-generated document.",
                      textScaleFactor: 1.5),
                ],
              ),
            ]),
      ]),
    );
  }
}
