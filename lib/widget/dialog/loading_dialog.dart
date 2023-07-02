import 'package:flutter/material.dart';
import 'package:sounding_storage/base/constants/strings.dart';

import '../loading/loading_progress.dart';

loadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0.0,
        child: Container(
          width: 100.0,
          height: 100.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadingProgress(),
              Padding(padding: EdgeInsets.all(10)),
              Text(Strings.PLEASE_WAIT)
            ],
          ),
        ),
      );
    },
  );
}
