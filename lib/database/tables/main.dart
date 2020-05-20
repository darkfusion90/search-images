import 'favorites.dart' as favoritesTable;
import 'images.dart' as imagesTable;
import 'imageUrls.dart' as imageUrlsTable;

enum DatabaseTable { favorites, images, imageUrls }

class UnknownDatabaseTableException implements Exception {
  String _message;

  UnknownDatabaseTableException(DatabaseTable table)
      : _message = 'Unknown DatabaseTable: $table';

  @override
  String toString() {
    return _message;
  }
}

String getCreateTableStatement(DatabaseTable table) {
  switch (table) {
    case DatabaseTable.favorites:
      return favoritesTable.createTableStatement;
    case DatabaseTable.images:
      return imagesTable.createTableStatement;
    case DatabaseTable.imageUrls:
      return imageUrlsTable.createTableStatement;
    default:
      throw UnknownDatabaseTableException(table);
  }
}
