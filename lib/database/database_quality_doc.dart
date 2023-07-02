import 'package:intl/intl.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/database/database_quality_check.dart';
import 'package:sounding_storage/model/quality.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class DatabaseQuality {
  Future<List<Quality>> selectQualityDoc() async {
    String username = await StorageUtils.readData('username');
    List<Quality> listQuality = [];
    Database db = await DatabaseHelper().database;
    var mapList = await db.rawQuery(
        "SELECT * FROM $TABLE_QUALITY_DOC WHERE $CREATED_BY_QUALITY_DOC=?",
        [username]);
    for (int i = 0; i < mapList.length; i++) {
      Quality quality = Quality.fromJson(mapList[i]);
      listQuality.add(quality);
    }
    return listQuality;
  }

  Future<int> selectQualityDocUnSent() async {
    String username = await StorageUtils.readData('username');
    Database db = await DatabaseHelper().database;
    var mapList = await db.rawQuery(
        "SELECT * FROM $TABLE_QUALITY_DOC WHERE $CREATED_BY_QUALITY_DOC=? AND $QUALITY_SENT_DOC=?",
        [username, "false"]);
    return mapList.length;
  }

  Future<int> insertQualityDoc(Quality object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.insert(TABLE_QUALITY_DOC, object.toJson());
    return count;
  }

  Future<int> updateQualityTransferred(Quality object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.rawUpdate(
        'UPDATE $TABLE_QUALITY_DOC SET $QUALITY_SENT_DOC = ? WHERE $ID_QUALITY_DOC = ?',
        ["true", object.number]);
    return count;
  }

  Future<int> updateQualityDoc(Quality object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.update(TABLE_QUALITY_DOC, object.toJson(),
        where: '$ID_QUALITY=?', whereArgs: [object.number]);
    return count;
  }

  Future<int> deleteQualityDoc(Quality object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.delete(TABLE_QUALITY_DOC,
        where: '$ID_QUALITY=?', whereArgs: [object.number]);
    if (count > 0) {
      DatabaseQualityCheck().deleteQualityCheck(object);
    }
    return count;
  }

  Future<int> deleteDeleteQualityOneWeekAgo() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 7);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_QUALITY_DOC WHERE $DATE_QUALITY_DOC LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_QUALITY WHERE $DATE_QUALITY LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteQualityOneWeekAgo1() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 8);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_QUALITY_DOC WHERE $DATE_QUALITY_DOC LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_QUALITY WHERE $DATE_QUALITY LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteQualityOneWeekAgo2() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 9);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_QUALITY_DOC WHERE $DATE_QUALITY_DOC LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_QUALITY WHERE $DATE_QUALITY LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteQualityOneWeekAgo3() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 10);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_QUALITY_DOC WHERE $DATE_QUALITY_DOC LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_QUALITY WHERE $DATE_QUALITY LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteQualityOneWeekAgo4() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 11);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_QUALITY_DOC WHERE $DATE_QUALITY_DOC LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_QUALITY WHERE $DATE_QUALITY LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteQualityOneWeekAgo5() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 12);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_QUALITY_DOC WHERE $DATE_QUALITY_DOC LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_QUALITY WHERE $DATE_QUALITY LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteQualityOneWeekAgo6() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 13);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_QUALITY_DOC WHERE $DATE_QUALITY_DOC LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_QUALITY WHERE $DATE_QUALITY LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }
}
