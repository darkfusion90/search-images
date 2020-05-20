import 'package:sqflite/sqflite.dart';

import 'package:searchimages/database/tables/main.dart';
import 'package:searchimages/database/main.dart';

Future<Database> initDbControllerForTable(DatabaseTable table) async {
  final Database db = await initDb().getDatabase();
  _performTransaction(db, table);
  
  return db;
}

Future _performTransaction(Database db, DatabaseTable table) async {
  try {
    db.transaction((tran) => tran.execute(getCreateTableStatement(table)));
  } catch (on, stackTrace) {
    print('Exception caught while performing transaction for table $table:');
    print('$on\nStack Trace: $stackTrace');
  }
}
