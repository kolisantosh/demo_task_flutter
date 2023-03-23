import 'package:attendancewithqr/database/db_helper.dart';
import 'package:attendancewithqr/model/report.dart';
import 'package:attendancewithqr/utils/strings.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DbHelper dbHelper = DbHelper();
  Future<List<Report>> reports;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    if (mounted) {
      setState(() {
        reports = dbHelper.getReports();
      });
    }
  }

  SingleChildScrollView dataTable(List<Report> reports) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                report_date,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                report_time,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                report_type,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                report_location,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: reports
              .map(
                (report) => DataRow(cells: [
                  DataCell(
                    Text(report.date),
                  ),
                  DataCell(
                    Text(report.time),
                  ),
                  DataCell(
                    Text(report.type),
                  ),
                  DataCell(
                    Text(report.location),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: reports,
        builder: (context, snapshot) {
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Center(child: Text(report_no_data));
          }

          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(report_title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            list(),
          ],
        ),
      ),
    );
  }
}
