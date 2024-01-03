import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  Database? _database;

  DatabaseHelper.internal() {
    initDatabase();
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'desafio.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('DROP TABLE IF EXISTS LocalEntity');
        await db.execute('DROP TABLE IF EXISTS AssetEntity');
        await db.execute('''
          CREATE TABLE LocalEntity (
            id TEXT PRIMARY KEY,
            name TEXT,
            parentId TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE AssetEntity (
            id TEXT PRIMARY KEY,
            name TEXT,
            locationId TEXT,
            parentId TEXT,
            sensorType TEXT,
            status TEXT
          )
        ''');
      },
    );
  }
}
