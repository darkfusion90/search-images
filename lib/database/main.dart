import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;
import 'config.dart' show dbConfig;

class DbSingleton {
  static final DbSingleton _singleton = DbSingleton._instantiate();
  sqlite.Database _database;

  DbSingleton._instantiate();

  factory DbSingleton() {
    return _singleton;
  }

  Future<sqlite.Database> getDatabase() async {
    if (_database == null) {
      final String dbPath =
          path.join(await sqlite.getDatabasesPath(), dbConfig['db_name']);
      _database = await sqlite.openDatabase(dbPath);
    }

    return _database;
  }
}

DbSingleton initDb() {
  return DbSingleton();
}
