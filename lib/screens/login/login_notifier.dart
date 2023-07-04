import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/utils/navigator_utils.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/database/database_helper.dart';
import 'package:sounding_storage/model/mill.dart';
import 'package:sounding_storage/model/response.dart';
import 'package:sounding_storage/model/storage_tank.dart';
import 'package:sounding_storage/model/user.dart';
import 'package:sounding_storage/repositories/login_repository.dart';
import 'package:sounding_storage/screens/home/home_screen.dart';
import 'package:sounding_storage/widget/dialog/loading_dialog.dart';
import 'package:sqflite/sqflite.dart';

class LoginNotifier extends ChangeNotifier {
  bool isLoading = false;

  doLogin(BuildContext context, String username, String password) {
    loadingDialog(context);
    LoginRepository(APIEndpoint.BASE_URL)
        .doPostLogin(context, username, password, onSuccessLogin, onErrorLogin);
  }

  onSuccessLogin(BuildContext context, Response response) async {
    insertUser(response.data.user).then((value) {
      if (value > 0) {
        insertMill(response.data.setup.mill).then((value) {
          if (value > 0) {
            insertStorageTank(response.data.setup.storageTank).then((value) {
              if (value > response.data.setup.storageTank.length) {
                StorageUtils.saveData('session', 'enable');
                StorageUtils.saveData('token', response.data.token);
                StorageUtils.saveData(
                    'productId', response.data.setup.product[0].id);
                StorageUtils.saveData('username', response.data.user.username);
                StorageUtils.saveData('max_sounding',
                    response.data.setup.mill.totalSampleSoundingCpo);
                setCompany(response.data.user.companyName,
                    response.data.user.companyAlias);
                log('cek companyName : ${response.data.user.companyName}');
                log('cek companyAlias : ${response.data.user.companyAlias}');
                NavigatorUtils.navigateTo(context, HomeScreen());
              } else {
                warningDialog(context, Strings.LOGIN_FAILED,
                    Strings.FAILED_GET_STORAGE_TANK);
              }
            });
          } else {
            warningDialog(
                context, Strings.LOGIN_FAILED, Strings.FAILED_GET_MILL);
          }
        });
      } else {
        warningDialog(context, Strings.LOGIN_FAILED, Strings.FAILED_GET_USER);
      }
    });
  }

  onErrorLogin(BuildContext context, String response) {
    Navigator.pop(context);
    warningDialog(context, "Gagal Login", response);
  }

  Future<int> insertUser(User object) async {
    Database db = await DatabaseHelper().database;
    User userThis = User();
    userThis.id = object.id;
    userThis.name = object.name;
    userThis.email = object.email;
    userThis.mRoleId = object.mRoleId;
    userThis.username = object.username;
    userThis.address = object.address;
    userThis.gender = object.gender;
    userThis.rememberToken = object.rememberToken;
    userThis.mMillId = object.mMillId;
    userThis.companyName = object.companyName;
    userThis.mCompanyId = object.mCompanyId;
    userThis.phoneNumber = object.phoneNumber;
    userThis.profilePicture = object.profilePicture;
    int countUser = await db.insert(TABLE_USER, userThis.toJson());
    return countUser;
  }

  Future<int> insertMill(Mill object) async {
    Database db = await DatabaseHelper().database;
    int countMill = await db.insert(TABLE_MILL, object.toJson());
    return countMill;
  }

  setCompany(String company, String companyAlias) {
    StorageUtils.saveData('company_name', company);
    StorageUtils.saveData('company_alias', companyAlias);
  }

  Future<int> insertStorageTank(List<StorageTank> object) async {
    List<StorageTank> reversed = object;
    Database db = await DatabaseHelper().database;
    int count = 0;
    for (int i = 0; i < reversed.length; i++) {
      int countStorageTank =
          await db.insert(TABLE_STORAGE_TANK, reversed[i].toJson());
      count = count + countStorageTank;
    }
    return count;
  }

  warningDialog(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              new TextButton(
                  child: new Text(
                    "Ok",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}
