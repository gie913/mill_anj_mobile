import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sounding_storage/base/constants/paths.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/base/utils/navigator_utils.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/screens/home/home_screen.dart';
import 'package:sounding_storage/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    autoLogIn();
    super.initState();
  }

  void autoLogIn() async {
    String session = await StorageUtils.readData('session');
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      if (session != null) {
        NavigatorUtils.navigateTo(context, HomeScreen());
      } else {
        NavigatorUtils.navigateTo(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Flexible(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Paths.IMAGE_APP,
                              width: MediaQuery.of(context).size.width * 0.2),
                          SizedBox(width: 10),
                          Text(
                            Strings.ANJ_LOGO,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.12),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(Strings.APP_NAME, style: text24Bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Text(Strings.POWERED_BY),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
