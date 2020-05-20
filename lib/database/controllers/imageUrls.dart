import 'package:searchimages/database/controllers/initControllerUtil.dart';

import 'package:searchimages/database/tables/main.dart';
import 'package:searchimages/database/tables/imageUrls.dart' as imageUrlsTable;
import 'package:sqflite/sqflite.dart';

Future<Database> _init() async {
  return initDbControllerForTable(DatabaseTable.imageUrls);
}

Future<void> insertImageUrl(Map<String, dynamic> urlMap) async {
  Database db = await _init();
  await db.insert(
    imageUrlsTable.tableName,
    urlMap,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<Map<String, dynamic>> getImageUrl(String imageThumbUrl) async {
  Database db = await _init();

  List<Map<String, dynamic>> results = await db.query(
    imageUrlsTable.tableName,
    where: '${imageUrlsTable.columnNameThumb}= ?',
    whereArgs: [imageThumbUrl],
  );

  return results.isEmpty ? null : results[0];
}
