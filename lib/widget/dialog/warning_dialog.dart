
import 'package:flutter/material.dart';

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
                child: new Text("Ok", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                })
          ],
        );
      });
}
