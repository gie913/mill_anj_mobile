import 'package:sounding_storage/database/database_helper.dart';
import 'package:sounding_storage/model/user.dart';
import 'package:sqflite/sqflite.dart';

import 'database_entity.dart';

class DatabaseUser {
  Future<User> selectUser() async {
    Database db = await DatabaseHelper().database;
    var mapList = await db.rawQuery("SELECT * FROM $TABLE_USER");
    User user = User.fromJson(mapList[0]);
    return user;
  }

  Future<int> insertUser(User user) async {
    Database db = await DatabaseHelper().database;
    int count = await db.insert(TABLE_USER, user.toJson());
    return count;
  }

  Future<int> updateUser(User user) async {
    Database db = await DatabaseHelper().database;
    int count = await db.update(TABLE_USER, user.toJson(),
        where: '$ID_USER=?', whereArgs: [user.id]);
    return count;
  }

  Future<int> deleteUser(User user) async {
    Database db = await DatabaseHelper().database;
    int count =
        await db.delete(TABLE_USER, where: '$ID_USER=?', whereArgs: [user.id]);
    return count;
  }
}
