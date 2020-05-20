import 'package:sqflite/sqflite.dart' as sqlite;

import 'package:searchimages/database/main.dart' show initDb;
import 'package:searchimages/database/models/SearchQuery.dart';

const String TABLE_NAME = 'searchqueries';
const String UniqueNonNullStringColumn = 'VARCHAR(255) UNIQUE NOT NULL';

Future<sqlite.Database> init() async {
  final sqlite.Database db = await initDb().getDatabase();
  await db.execute(
    'CREATE TABLE IF NOT EXISTS $TABLE_NAME('
    'id INTEGER PRIMARY KEY AUTOINCREMENT, '
    'query $UniqueNonNullStringColumn, '
    'queriedOn $UniqueNonNullStringColumn'
    ')',
  );

  return db;
}

Future<SearchQuery> createSearchQuery(String queryString) async {
  sqlite.Database db = await init();
  final SearchQuery searchQuery = SearchQuery(queryString, DateTime.now());

  int id = await db.insert(
    TABLE_NAME,
    searchQuery.toMap(),
    conflictAlgorithm: sqlite.ConflictAlgorithm.replace,
  );

  searchQuery.setId(id);
  return searchQuery;
}

Future<List<SearchQuery>> getAllSearchQueries() async {
  sqlite.Database db = await init();

  List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
  return SearchQuery.fromMaps(maps);
}

Future<void> deleteSearchQuery(String query) async {
  sqlite.Database db = await init();

  return db.delete(TABLE_NAME, where: 'query= ?', whereArgs: [query]);
}
