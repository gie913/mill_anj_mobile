import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/model/mill.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class DatabaseMill {
  Future<List<Map<String, dynamic>>> selectMill() async {
    Database db = await DatabaseHelper().database;
    var mapList = await db.rawQuery("SELECT * FROM $TABLE_MILL");
    return mapList;
  }

  Future<int> insertMill(Mill object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.insert(TABLE_MILL, object.toJson());
    return count;
  }

  Future<int> updateMill(Mill object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.update(TABLE_MILL, object.toJson(),
        where: '$ID_MILL=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> deleteMill(Mill object) async {
    Database db = await DatabaseHelper().database;
    int count = await db
        .delete(TABLE_MILL, where: '$ID_MILL=?', whereArgs: [object.id]);
    return count;
  }

  Future<List<Mill>> getSoundingListMill() async {
    var millMapList = await selectMill();
    int count = millMapList.length;
    List<Mill> millList = [];
    for (int i = 0; i < count; i++) {
      millList.add(Mill.fromJson(millMapList[i]));
    }
    return millList;
  }
}
