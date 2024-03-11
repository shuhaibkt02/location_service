import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class LocationDB {
  String databaseName = 'location.db';
  String tableName = 'locationTable';
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<String> get fullPath async {
    String path = await getDatabasesPath();
    return join(path, databaseName);
  }

  Future<Database> initDatabase() async {
    final dbPath = await fullPath;
    Future<Database> database = openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) => createDb(db, version),
    );
    return database;
  }

  Future<void> createDb(Database db, int version) async => await db.execute(
      '''CREATE TABLE $tableName(placeholder TEXT NOT NULL,latitude REAL, longitude REAL, timestamp TEXT)''');
}
