import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/database/database_entity.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class DatabaseLocalUpdate {
  void addNewColumnOnVersion() async {
    Database db = await DatabaseHelper().database;
    try {
      await db.rawQuery(
          "ALTER TABLE $TABLE_SOUNDING_CPO ADD COLUMN $SOUNDING_USING_COPY_DATA BOOL NOT NULL DEFAULT FALSE;");
    } catch (e) {
      print("Column copy data exist");
    }
  }

  void addTableOnVersion() async {
    Database db = await DatabaseHelper().database;
    try {
      await db.execute('''
      CREATE TABLE $TABLE_VERIFIER(
        $ID_VERIFIER TEXT NOT NULL,
        $NAME_VERIFIER TEXT NOT NULL,
        $LEVEL_LABEL TEXT NOT NULL,
        $ID_FORM TEXT)
    ''');
    } catch (e) {
      print("Table exist");
    }
  }

  void addNewColumnOnVersionCreatedBy() async {
    Database db = await DatabaseHelper().database;
    String username = await StorageUtils.readData('username');
    try {
      await db.rawQuery(
          "ALTER TABLE $TABLE_SOUNDING_CPO ADD COLUMN $SOUNDING_CPO_CREATED_BY BOOL NOT NULL DEFAULT $username;");
    } catch (e) {
      print("Column created by exist");
    }
  }
}
