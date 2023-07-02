import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sounding_storage/database/database_helper.dart';
import 'package:sounding_storage/database/database_sounding.dart';
import 'package:sounding_storage/database/database_sounding_cpo.dart';
import 'package:sounding_storage/model/sounding.dart';
import 'package:sqflite/sqflite.dart';

class ListSoundingNotifier extends ChangeNotifier {
  DatabaseHelper _dbHelper = DatabaseHelper();
  DatabaseSounding dbSounding = DatabaseSounding();
  DatabaseSoundingCpo dbSoundingCpo = DatabaseSoundingCpo();
  List<Sounding> _soundingList = [];
  List<Sounding> _soundingListSearch = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Sounding> get soundingList => _soundingList;

  List<Sounding> get soundingListSearch => _soundingListSearch;

  void updateListView() {
    final Future<Database> dbFuture = _dbHelper.initDb();
    _isLoading = true;
    dbFuture.then((database) {
      Future<List<Sounding>> soundingListFuture = dbSounding.selectSounding();
      soundingListFuture.then((soundingList) {
        _soundingList = soundingList.reversed.toList();
        _isLoading = false;
        notifyListeners();
      });
    });
  }

  void addHarvestTicket(Sounding object) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('username');
    object.createdBy = user;
    int result = await dbSounding.insertSounding(object);
    if (result > 0) {
      updateListView();
    }
  }

  void editHarvestTicket(Sounding object) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('username');
    object.createdBy = user;
    int result = await dbSounding.updateSounding(object);
    if (result > 0) {
      updateListView();
    }
  }

  void deleteHarvestTicket(Sounding object) async {
    soundingListSearch.remove(object);
    int result = await dbSounding.deleteSounding(object);
      if(result > 0) {
        updateListView();
      }
  }

  onSearchTextChanged(String text) async {
    _soundingListSearch.clear();
    if (text.isEmpty) {
      updateListView();
    }
    _soundingList.forEach((soundingDetail) {
      if (soundingDetail.number
              .toLowerCase()
              .contains(text.toLowerCase()) ||
          soundingDetail.production
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) ||
          soundingDetail.trTime
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
        _soundingListSearch.add(soundingDetail);
    });
    notifyListeners();
  }
}
