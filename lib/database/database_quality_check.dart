import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/model/quality.dart';
import 'package:sounding_storage/model/quality_check.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class DatabaseQualityCheck {
  Future<List<QualityCheck>> selectQualityCheck(Quality quality) async {
    Database db = await DatabaseHelper().database;
    List<QualityCheck> listQualityCheck = [];
    var mapList = await db.rawQuery("SELECT * FROM $TABLE_QUALITY WHERE $ID_QUALITY_DOC_CHECK=?", [quality.number]);
    for(int i=0; i<mapList.length;i++){
      QualityCheck qualityCheck = QualityCheck.fromJson(mapList[i]);
      listQualityCheck.add(qualityCheck);
    }
    return listQualityCheck;
  }

  Future<int> insertQualityCheck(QualityCheck object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.insert(TABLE_QUALITY, object.toJson());
    return count;
  }

  Future<int> updateQualityCheck(QualityCheck object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.update(TABLE_QUALITY, object.toJson(),
        where: '$ID_QUALITY=?', whereArgs: [object.number]);
    return count;
  }

  Future<int> deleteQualityCheck(Quality object) async {
    Database db = await DatabaseHelper().database;
    int count = await db
        .delete(TABLE_QUALITY, where: '$ID_QUALITY_DOC_CHECK=?', whereArgs: [object.number]);
    return count;
  }
}
