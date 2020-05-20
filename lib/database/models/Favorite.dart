import 'package:searchimages/database/tables/favorites.dart' as favoritesTable;

class Favorite {
  int id;
  final String imageId;

  Favorite(this.imageId, {this.id});

  void setId(int id) {
    this.id = id;
  }

  Map<String, dynamic> toDbMap() {
    return {
      favoritesTable.columnNameId: id,
      favoritesTable.columnNameImageId: imageId,
    };
  }

  static Favorite fromMap(Map<String, dynamic> map) {
    return Favorite(
      map[favoritesTable.columnNameImageId],
      id: map[favoritesTable.columnNameId],
    );
  }

  static List<Favorite> fromMaps(List<Map<String, dynamic>> maps) {
    return List<Favorite>.generate(
      maps.length,
      (index) => fromMap(maps[index]),
    );
  }

  @override
  String toString() {
    return "{'id': $id, 'imageId': $imageId}\n";
  }
}
