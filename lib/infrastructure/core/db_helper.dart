import 'dart:io' as io;
import 'package:employee_app/infrastructure/core/db_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();

  factory DbHelper() => _instance;
  static Database? _db;
  DbHelper.internal();

  Database? get db {
    return _db;
  }

  Future<void> initializeDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DbConstants.dbEmployee);
    _db = await openDatabase(path, version: DbConstants.dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute(DbConstants.createTblEmployeeQuery);
    } catch (_) {}
  }
}
