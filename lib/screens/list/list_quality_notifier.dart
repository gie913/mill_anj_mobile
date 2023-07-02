import 'package:flutter/material.dart';
import 'package:sounding_storage/database/database_helper.dart';
import 'package:sounding_storage/database/database_quality_doc.dart';
import 'package:sounding_storage/model/quality.dart';
import 'package:sqflite/sqflite.dart';

class ListQualityNotifier extends ChangeNotifier {
  DatabaseHelper _dbHelper = DatabaseHelper();
  DatabaseQuality dbQuality = DatabaseQuality();

  List<Quality> _qualityList = [];
  List<Quality> _qualityListSearch = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Quality> get qualityList => _qualityList;

  List<Quality> get qualityListSearch => _qualityListSearch;

  void updateListView() {
    final Future<Database> dbFuture = _dbHelper.initDb();
    _isLoading = true;
    dbFuture.then((database) {
      Future<List<Quality>> qualityListFuture = dbQuality.selectQualityDoc();
      qualityListFuture.then((qualityList) {
        _qualityList = qualityList.reversed.toList();
        _isLoading = false;
        notifyListeners();
      });
    });
  }

  void addHarvestTicket(Quality object) async {
    int result = await dbQuality.insertQualityDoc(object);
    if (result > 0) {
      updateListView();
    }
  }

  void editHarvestTicket(Quality object) async {
    int result = await dbQuality.updateQualityDoc(object);
    if (result > 0) {
      updateListView();
    }
  }

  void deleteHarvestTicket(Quality object) async {
    qualityListSearch.remove(object);
    int result = await dbQuality.deleteQualityDoc(object);
    if (result > 0) {
      updateListView();
    }
  }

  onSearchTextChanged(String text) async {
    _qualityListSearch.clear();
    if (text.isEmpty) {
      updateListView();
    }
    _qualityList.forEach((qualityDetail) {
      if (qualityDetail.number.toLowerCase().contains(text.toLowerCase()) ||
          qualityDetail.trTime
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
        _qualityListSearch.add(qualityDetail);
    });
    notifyListeners();
  }
}
