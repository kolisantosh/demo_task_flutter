import 'dart:async';
import 'dart:io';

import 'package:attendancewithqr/model/report.dart';
import 'package:attendancewithqr/model/settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  // Db name file
  String dbName = 'report.db';

  // table name
  String tableSettings = 'settings';
  String tableReport = 'reports';

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    // Init name and directory of DB
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + dbName;

    // Create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  // Create the table
  void _createDb(Database db, int version) async {
    // Table for settings
    await db.execute('''
      CREATE TABLE $tableSettings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT,
        key TEXT
        )
    ''');

    // Table for Report
    await db.execute('''
      CREATE TABLE $tableReport (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        time TEXT,
        location TEXT,
        type TEXT
        )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  //--------------------------- Settings --------------------------------------
  // Check there is any data
  countSettings() async {
    final db = await database;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableSettings'));
    return count;
  }

  // Insert new data
  newSettings(Settings newSettings) async {
    final db = await database;
    var result = await db.insert(tableSettings, newSettings.toMap());
    return result;
  }

  // Get the data by id
  getSettings(int id) async {
    final db = await database;
    var res = await db.query(tableSettings, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Settings.fromMap(res.first) : null;
  }

  // Update the data
  updateSettings(Settings updateSettings) async {
    final db = await database;
    var result = await db.update(tableSettings, updateSettings.toMap(),
        where: "id = ?", whereArgs: [updateSettings.id]);
    return result;
  }

  //--------------------------- Report -------------------------------------

  // Insert new data report
  newReports(Report newReport) async {
    final db = await database;
    var result = await db.insert(tableReport, newReport.toMap());
    return result;
  }

  // Get All report
  Future<List<Report>> getReports() async {
    final db = await database;
    List<Map> maps = await db.rawQuery(
        "SELECT * FROM $tableReport ORDER BY date(date) DESC, time(time) DESC");
    List<Report> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Report.fromMap(maps[i]));
      }
    }
    return employees;
  }
}
