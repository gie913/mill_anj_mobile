
import 'package:flutter/material.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';

import 'palette.dart';

class ThemeNotifier with ChangeNotifier {

  final darkTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Color(0xFF212121),
    primaryColorLight: Colors.black,
    brightness: Brightness.dark,
    dividerTheme: DividerThemeData(color: Colors.grey),
    backgroundColor: Colors.black,
    accentColor: Colors.white,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
        ),
        backgroundColor: MaterialStateProperty.all(primaryColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
              )
          ),
        backgroundColor: MaterialStateProperty.all(primaryColor),
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    highlightColor: Colors.black,
    primaryColorDark: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.black,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    brightness: Brightness.light,
    indicatorColor: Colors.orange,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
        ),
        backgroundColor: MaterialStateProperty.all(primaryColor),
      ),
    ),
    scaffoldBackgroundColor: Color(0xFFF9F9F9),
    cardColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
        ),
        backgroundColor: MaterialStateProperty.all(primaryColor),
      ),
    ),
    backgroundColor: primaryColorLight,
    accentColor: Colors.orange,
  );

  ThemeData _themeData;

  bool _status;

  bool get status => _status;

  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    _status = false;
    StorageUtils.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
        _status = false;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
        _status = true;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    _status = true;
    StorageUtils.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    _status = false;
    StorageUtils.saveData('themeMode', 'light');
    notifyListeners();
  }
}
