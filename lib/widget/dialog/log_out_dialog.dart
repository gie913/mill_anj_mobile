
import 'package:flutter/material.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/screens/home/home_notifier.dart';

showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(Strings.LOG_OUT),
        content: Text(Strings.DIALOG_LOG_OUT),
        actions: [
          TextButton(
            child: Text(Strings.YES,
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold)),
            onPressed: () {
              HomeNotifier().doLogOut(context);
            },
          ),
          TextButton(
            child: Text(Strings.NO,
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}