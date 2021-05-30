import 'package:flutter/material.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => new Dialog(
              child: Container(
                width: 120,
                height: 80,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(msg, style: TextStyle(fontSize: 18))),
                    ],
                  ),
                ),
              ),
            ));
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog);
  }
}
//barrierDismissible: is allowed to hide when clicking outside
