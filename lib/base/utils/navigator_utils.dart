import 'package:flutter/material.dart';

class NavigatorUtils {
  static navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
