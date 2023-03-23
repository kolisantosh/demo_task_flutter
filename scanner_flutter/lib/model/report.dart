import 'dart:convert';

Report attendanceFromJson(String str) {
  final jsonData = json.decode(str);
  return Report.fromMap(jsonData);
}

String attendanceToJson(Report data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Report {
  int id;
  String date;
  String time;
  String location;
  String type;

  Report({this.id, this.date, this.time, this.location, this.type});

  factory Report.fromMap(Map<String, dynamic> json) => Report(
        id: json["id"],
        date: json["date"],
        time: json["time"],
        location: json["location"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "time": time,
        "location": location,
        "type": type,
      };
}
