import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sounding_storage/base/constants/strings.dart';

Future<bool> onWillPop(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Keluar'),
      content: Text('Apakah Anda ingin keluar ?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => exit(0),
          child: Text(Strings.YES, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(Strings.NO, style : TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
