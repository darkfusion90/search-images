import 'imageUrls.dart' as imageUrlsTable;

const String tableName = 'images';

const String columnNameId = 'id';
const String columnNameImageUrlId = 'imageUrlId';
const String columnNameAltDesc = 'alt_description';
const String columnNameWidth = 'width';
const String columnNameHeight = 'height';

const String _foreignKey = columnNameImageUrlId;
const String _foreignKeyReference =
    imageUrlsTable.tableName + '(${imageUrlsTable.columnNameThumb})';

const String _foreignKeyDescription =
    'FOREIGN KEY($_foreignKey) REFERENCES $_foreignKeyReference ';

final String createTableStatement = 'CREATE TABLE IF NOT EXISTS $tableName('
    '$columnNameId VARCHAR(255) PRIMARY KEY, '
    '$columnNameImageUrlId VARCHAR(255) UNIQUE NOT NULL, '
    '$columnNameAltDesc VARCHAR(255), '
    '$columnNameWidth INTEGER NOT NULL, '
    '$columnNameHeight INTEGER NOT NULL,'
    '$_foreignKeyDescription '
    ')';
