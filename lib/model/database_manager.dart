import 'package:async/async.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseManager {
  static const String SQL_SCHEMA = '''
  ''';

  static final DatabaseManager _instance = new DatabaseManager._internal();

  DatabaseManager._internal();

  // this is the interface for accessing the instance of the database manager
  static DatabaseManager get instance => _instance;

  // Members
  static Database _database;

  // using this to prevent race conditions. pretty sure it's similar to a mutex
  // this prevents duplicate function calls where used
  final _initDBMemoizer = AsyncMemoizer<Database>();
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDBMemoizer.runOnce(() async {
      return await _initializeDatabase();
    });

    return _database;
  }

  Future<Database> _initializeDatabase() async {
    // i think we may need to copy an existing database file from the assets
    // to the database path

    String databaseFilePath = join(await getDatabasesPath(), 'data.db');
    Database database =
        await openDatabase(databaseFilePath, onCreate: (db, version) {
      return db.execute(SQL_SCHEMA);
    }, version: 1);

    return database;
  }
}
