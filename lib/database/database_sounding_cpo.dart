import 'package:intl/intl.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/model/sounding.dart';
import 'package:sounding_storage/model/sounding_cpo.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class DatabaseSoundingCpo {
  Future<List<SoundingCpo>> selectSoundingCpo(Sounding sounding) async {
    Database db = await DatabaseHelper().database;
    var mapList = await db.rawQuery(
        "SELECT * FROM $TABLE_SOUNDING_CPO WHERE $ID_SOUNDING_TANK=?",
        [sounding.number]);
    List<SoundingCpo> listSoundingCpo = [];
    for (int i = 0; i < mapList.length; i++) {
      SoundingCpo soundingCpo = SoundingCpo.fromJson(mapList[i]);
      listSoundingCpo.add(soundingCpo);
    }
    return listSoundingCpo;
  }

  Future<int> selectSoundingCpoByIDCpo(SoundingCpo soundingCpo) async {
    Database db = await DatabaseHelper().database;
    var mapList = await db.rawQuery(
        "SELECT * FROM $TABLE_SOUNDING_CPO WHERE $ID_TANK=?",
        [soundingCpo.number]);
    return mapList.length;
  }

  Future<List<SoundingCpo>> selectSoundingYesterday() async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year, date.month, date.day - 1);
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    Database db = await DatabaseHelper().database;
    String username = await StorageUtils.readData('username');
    var mapList = await db.rawQuery(
        'SELECT * FROM $TABLE_SOUNDING_CPO WHERE $CREATED_BY_STORAGE_TANK=? AND $DATE_SOUNDING_TANK LIKE ?',
        [username, '${formattedDate.toString()}%']);
    List<SoundingCpo> listSoundingCpo = [];
    for (int i = 0; i < mapList.length; i++) {
      SoundingCpo soundingCpo = SoundingCpo.fromJson(mapList[i]);
      listSoundingCpo.add(soundingCpo);
    }
    return listSoundingCpo;
  }

  Future<int> insertSoundingCpo(SoundingCpo object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.insert(TABLE_SOUNDING_CPO, object.toJson());
    return count;
  }

  Future<int> updateSoundingCpo(SoundingCpo object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.update(TABLE_SOUNDING_CPO, object.toJson(),
        where: '$ID_SOUNDING=?', whereArgs: [object.number]);
    return count;
  }

  Future<int> deleteSoundingCpo(Sounding object) async {
    Database db = await DatabaseHelper().database;
    int count = await db.delete(TABLE_SOUNDING_CPO,
        where: '$ID_SOUNDING_TANK=?', whereArgs: [object.number]);
    return count;
  }
}
