import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static late Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "calculator.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE History(id INTEGER PRIMARY KEY, calculation TEXT, time TEXT)",
    );
  }

  Future<int> saveHistory(String calculation, String time) async {
    var dbClient = await db;
    int res = await dbClient.insert("History", {
      "calculation": calculation,
      "time": time,
    });
    return res;
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    var dbClient = await db;
    var res = await dbClient.query("History", orderBy: "id DESC");
    return res;
  }
}
