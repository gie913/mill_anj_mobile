import 'package:flutter/material.dart';
import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/database/database_helper.dart';
import 'package:sounding_storage/model/storage_tank.dart';
import 'package:sqflite/sqflite.dart';

class FormSoundingNotifier extends ChangeNotifier {
  List<StorageTank> _storageTank = [];
  List<String> _items = [];

  List<StorageTank> get storageTank => _storageTank;

  List<String> get items => _items;

  doGetStorageTank(BuildContext context) async {
    _storageTank.clear();
    _items.clear();
    Database db = await DatabaseHelper().database;
    var mapList = await db.query(TABLE_STORAGE_TANK);
    for (int i = 0; i < mapList.length; i++) {
      StorageTank storageTank = StorageTank.fromJson(mapList[i]);
      _storageTank.add(storageTank);
      _items.add(storageTank.name);
    }
    print(items);
    notifyListeners();
  }
}
