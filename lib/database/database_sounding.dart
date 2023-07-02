import 'package:intl/intl.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/database/database_sounding_cpo.dart';
import 'package:sounding_storage/model/sounding.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class DatabaseSounding {
  Future<List<Sounding>> selectSounding() async {
    String username = await StorageUtils.readData('username');
    List<Sounding> listSounding = [];
    Database db = await DatabaseHelper().database;
    var mapList = await db.rawQuery(
        "SELECT * FROM $TABLE_SOUNDING WHERE $CREATED_BY_SOUNDING=?",
        [username]);
    for (int i = 0; i < mapList.length; i++) {
      Sounding sounding = Sounding.fromJson(mapList[i]);
      listSounding.add(sounding);
    }
    return listSounding;
  }

  Future<int> selectSoundingSent() async {
    String username = await StorageUtils.readData('username');
    Database db = await DatabaseHelper().database;
    var mapList = await db.rawQuery(
        "SELECT * FROM $TABLE_SOUNDING WHERE $CREATED_BY_SOUNDING=? AND $SOUNDING_SENT=?",
        [username, "false"]);
    return mapList.length;
  }

  Future<int> insertSounding(Sounding object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.insert(TABLE_SOUNDING, object.toJson());
    return count;
  }

  Future<int> updateSounding(Sounding object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.update(TABLE_SOUNDING, object.toJson(),
        where: '$ID_SOUNDING=?', whereArgs: [object.number]);
    return count;
  }

  Future<int> updateSoundingTransferred(Sounding object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.rawUpdate(
        'UPDATE $TABLE_SOUNDING SET $SOUNDING_SENT = ? WHERE $ID_SOUNDING = ?',
        ["true", object.number]);
    return count;
  }

  Future<int> deleteSounding(Sounding object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.delete(TABLE_SOUNDING,
        where: '$ID_SOUNDING=?', whereArgs: [object.number]);
    if (count > 0) {
      DatabaseSoundingCpo().deleteSoundingCpo(object);
    }
    return count;
  }

  Future<int> deleteDeleteSoundingOneWeekAgo() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 7);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_SOUNDING WHERE $DATE_SOUNDING LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_SOUNDING_CPO WHERE $DATE_SOUNDING_TANK LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteSoundingOneWeekAgo1() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 8);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_SOUNDING WHERE $DATE_SOUNDING LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_SOUNDING_CPO WHERE $DATE_SOUNDING_TANK LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteSoundingOneWeekAgo2() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 9);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_SOUNDING WHERE $DATE_SOUNDING LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_SOUNDING_CPO WHERE $DATE_SOUNDING_TANK LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteSoundingOneWeekAgo3() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 10);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_SOUNDING WHERE $DATE_SOUNDING LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_SOUNDING_CPO WHERE $DATE_SOUNDING_TANK LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteSoundingOneWeekAgo4() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 11);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_SOUNDING WHERE $DATE_SOUNDING LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_SOUNDING_CPO WHERE $DATE_SOUNDING_TANK LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteSoundingOneWeekAgo5() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 12);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_SOUNDING WHERE $DATE_SOUNDING LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_SOUNDING_CPO WHERE $DATE_SOUNDING_TANK LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }

  Future<int> deleteDeleteSoundingOneWeekAgo6() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 13);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    int count = await db.rawDelete(
        'DELETE FROM $TABLE_SOUNDING WHERE $DATE_SOUNDING LIKE ?',
        ['${formattedDate.toString()}%']);
    if (count > 0) {
      await db.rawDelete(
          'DELETE FROM $TABLE_SOUNDING_CPO WHERE $DATE_SOUNDING_TANK LIKE ?',
          ['${formattedDate.toString()}%']);
    }
    return count;
  }
}
