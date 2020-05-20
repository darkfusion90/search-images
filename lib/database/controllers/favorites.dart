import 'package:sqflite/sqflite.dart';

import 'package:searchimages/database/models/Favorite.dart' show Favorite;
import 'package:searchimages/database/models/Image.dart' show ImageModel;
import 'package:searchimages/database/tables/favorites.dart' as favoritesTable;
import 'package:searchimages/database/controllers/images.dart'
    as imagesController;
import 'package:searchimages/database/tables/main.dart';
import 'package:searchimages/database/controllers/initControllerUtil.dart';

Future<Database> init() async {
  return initDbControllerForTable(DatabaseTable.favorites);
}

Future<Favorite> createFavorite(ImageModel imageModel) async {
  await imagesController.insertImage(imageModel);

  Database db = await init();
  final Favorite favorite = Favorite(imageModel.id);

  int id = await db.insert(favoritesTable.tableName, favorite.toDbMap());

  favorite.setId(id);
  return favorite;
}

Future<List<Favorite>> getAllFavorites() async {
  Database db = await init();

  List<Map<String, dynamic>> maps = await db.query(favoritesTable.tableName);
  return Favorite.fromMaps(maps);
}

Future<void> deleteFavorite(ImageModel image) async {
  Database db = await init();

  return db.delete(
    favoritesTable.tableName,
    where: '${favoritesTable.columnNameImageId}= ?',
    whereArgs: [image.id],
  );
}

Future<bool> isImageFavorite(ImageModel image) async {
  Database db = await init();

  List<Map<String, dynamic>> results = await db.query(
    favoritesTable.tableName,
    where: '${favoritesTable.columnNameImageId}= ?',
    whereArgs: [image.id],
  );

  return results.isNotEmpty;
}
