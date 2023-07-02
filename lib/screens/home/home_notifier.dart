import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/database/database_helper.dart';
import 'package:sounding_storage/database/database_quality_doc.dart';
import 'package:sounding_storage/database/database_sounding.dart';
import 'package:sounding_storage/database/database_user.dart';
import 'package:sounding_storage/model/log_out_response.dart';
import 'package:sounding_storage/model/user.dart';
import 'package:sounding_storage/repositories/log_out_repository.dart';
import 'package:sounding_storage/screens/login/login_screen.dart';
import 'package:sounding_storage/widget/dialog/loading_dialog.dart';
import 'package:sounding_storage/widget/dialog/warning_dialog.dart';
import 'package:sqflite/sqflite.dart';

class HomeNotifier extends ChangeNotifier {
  User _user = User();
  int _soundingUnsent = 0;
  int _qualityUnsent = 0;

  User get user => _user;

  int get soundingUnsent => _soundingUnsent;

  int get qualityUnsent => _qualityUnsent;

  bool isLoading = false;

  doLogOut(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    loadingDialog(context);
    LogOutRepository(APIEndpoint.BASE_URL)
        .doGetLogOut(context, token, onSuccessLogOut, onErrorLogOut);
  }

  onSuccessLogOut(BuildContext context, LogOutResponse response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Database db = await DatabaseHelper().database;
    db.delete(TABLE_MILL);
    db.delete(TABLE_USER);
    db.delete(TABLE_STORAGE_TANK);
    prefs.remove('session');
    prefs.remove('token');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  onErrorLogOut(BuildContext context, String response) {
    Navigator.pop(context);
    warningDialog(context, "Gagal Log Out", response);
  }

  doGetUser(BuildContext context) async {
    User user = await DatabaseUser().selectUser();
    _user = user;
    notifyListeners();
  }

  doGetSoundingUnsent() async {
    _soundingUnsent = await DatabaseSounding().selectSoundingSent();
    notifyListeners();
  }

  doGetQualityUnsent() async {
    _qualityUnsent = await DatabaseQuality().selectQualityDocUnSent();
    notifyListeners();
  }
}
