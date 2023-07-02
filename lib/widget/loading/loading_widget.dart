import 'package:flutter/material.dart';
import 'package:sounding_storage/widget/loading/loading_progress.dart';

Widget loadingWidget() {
  return Flexible(
    child: Center(
      child: SizedBox(
        height: 30.0,
        width: 30.0,
        child: LoadingProgress(),
      ),
    ),
  );
}
