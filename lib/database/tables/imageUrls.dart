const String tableName = 'imageUrls';

const String columnNameRaw = 'raw';
const String columnNameRegular = 'regular';
const String columnNameFull = 'full';
const String columnNameSmall = 'small';
const String columnNameThumb = 'thumb';

const String createTableStatement = 'CREATE TABLE IF NOT EXISTS $tableName('
    '$columnNameRaw VARCHAR(255) NOT NULL, '
    '$columnNameRegular VARCHAR(255) NOT NULL, '
    '$columnNameFull VARCHAR(255) NOT NULL, '
    '$columnNameSmall VARCHAR(255) NOT NULL, '
    '$columnNameThumb VARCHAR(255) PRIMARY KEY'
    ')';
