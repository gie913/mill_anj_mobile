import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/database/database_helper.dart';
import 'package:sounding_storage/model/data_verifier.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseVerifier {
  Future<List<DataVerifier>> selectVerifier(String idForm) async {
    Database db = await DatabaseHelper().database;
    List<DataVerifier> listVerifier = [];
    var mapList = await db
        .rawQuery("SELECT * FROM $TABLE_VERIFIER WHERE $ID_FORM=?", [idForm]);
    for (int i = 0; i < mapList.length; i++) {
      DataVerifier verifier = DataVerifier();
      verifier.mUserId = mapList[i]['$ID_VERIFIER'];
      verifier.name = mapList[i]['$NAME_VERIFIER'];
      verifier.levelLabel = mapList[i]['$LEVEL_LABEL'];
      listVerifier.add(verifier);
    }
    return listVerifier;
  }

  Future<int> insertVerifier(DataVerifier verifier) async {
    Database db = await DatabaseHelper().database;
    int count = await db.insert(TABLE_VERIFIER, verifier.toJson());
    return count;
  }

  Future<int> updateUser(DataVerifier verifier) async {
    Database db = await DatabaseHelper().database;
    int count = await db.update(TABLE_VERIFIER, verifier.toJson(),
        where: '$ID_FORM=? AND $ID_VERIFIER',
        whereArgs: [verifier.idForm, verifier.mUserId]);
    return count;
  }

  Future<int> deleteUser(DataVerifier verifier) async {
    Database db = await DatabaseHelper().database;
    int count = await db.delete(TABLE_VERIFIER,
        where: '$ID_FORM=? AND $ID_VERIFIER',
        whereArgs: [verifier.idForm, verifier.mUserId]);
    return count;
  }
}
