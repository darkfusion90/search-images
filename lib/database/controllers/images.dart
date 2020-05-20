import 'package:sqflite/sqflite.dart';

import 'package:searchimages/database/controllers/initControllerUtil.dart';
import 'package:searchimages/database/controllers/imageUrls.dart'
    as imageUrlsController;

import 'package:searchimages/database/tables/main.dart';
import 'package:searchimages/database/tables/images.dart' as imagesTable;
import 'package:searchimages/database/models/Image.dart';

Future<Database> _init() async {
  return initDbControllerForTable(DatabaseTable.images);
}

Future<void> insertImage(ImageModel imageModel) async {
  await imageUrlsController.insertImageUrl(imageModel.urls);
  Database db = await _init();

  await db.insert(
    imagesTable.tableName,
    imageModel.toDbMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<Map<String, dynamic>> _getRawImage(String imageId) async {
  Database db = await _init();
  List<Map<String, dynamic>> results = await db.query(
    imagesTable.tableName,
    where: '${imagesTable.columnNameId}= ?',
    whereArgs: [imageId],
  );

  return results.isEmpty ? null : results[0];
}

Future<Map<String, dynamic>> _getImageUrlsForRawImage(
    Map<String, dynamic> rawImage) async {
  return imageUrlsController.getImageUrl(
    rawImage[imagesTable.columnNameImageUrlId],
  );
}

Future<ImageModel> getImage(String imageId) async {
  Map<String, dynamic> rawImage = await _getRawImage(imageId);
  Map<String, dynamic> rawImageUrls = await _getImageUrlsForRawImage(rawImage);

  // The value rawImage is apparently an immutable Map, hence cloning to put the additional key
  Map<String, dynamic> rawImageClone = Map.from(rawImage);
  rawImageClone.putIfAbsent('urls', () => rawImageUrls);

  return ImageModel.fromMap(rawImageClone);
}
