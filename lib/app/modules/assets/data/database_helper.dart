import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


final DatabaseFactory sqfliteDatabaseFactory = () {
  if (Platform.isAndroid || Platform.isIOS) {
    return databaseFactory;
  } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    sqfliteFfiInit();
    return databaseFactoryFfi;
  } else {
    throw UnsupportedError(
      'Platform ${Platform.operatingSystem} is not supported by Floor.',
    );
  }
}();

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
    final databasesPath = await sqfliteDatabaseFactory.getDatabasesPath();
    final path = join(databasesPath, 'desafio.db');

    return await sqfliteDatabaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: onCreateDatabase,
        ));
  }

  FutureOr<void> onCreateDatabase(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS LocalEntity');
    await db.execute('DROP TABLE IF EXISTS AssetEntity');
    await db.execute('''
        CREATE TABLE LocalEntity (
          id TEXT PRIMARY KEY,
          name TEXT,
          parentId TEXT,
          unit TEXT
        )
      ''');

    await db.execute('''
        CREATE TABLE AssetEntity (
          id TEXT PRIMARY KEY,
          name TEXT,
          locationId TEXT,
          parentId TEXT,
          sensorType TEXT,
          status TEXT,
          unit TEXT
        )
      ''');
  }
}
