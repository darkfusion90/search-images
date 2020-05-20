import 'images.dart' as imagesTable;

const String tableName = 'favorites';
const String columnNameId = 'id';
const String columnNameImageId = 'imageId';

const String _foreignKey = columnNameImageId;
const String _foreignKeyReference =
    imagesTable.tableName + '(${imagesTable.columnNameId})';

const String _foreignKeyDescription =
    'FOREIGN KEY($_foreignKey) REFERENCES $_foreignKeyReference ';

const String createTableStatement = 'CREATE TABLE IF NOT EXISTS $tableName('
    '$columnNameId INTEGER PRIMARY KEY AUTOINCREMENT, '
    '$columnNameImageId VARCHAR(255) UNIQUE NOT NULL,'
    '$_foreignKeyDescription '
    ')';
