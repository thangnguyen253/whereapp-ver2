import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/model/directionHistory.dart';
import 'package:flutter_application_1/src/resources/history-page.dart';

class MovingDialog {
  static void showMovingDialog(
      BuildContext context, String msg, DirectionHistory place) {
    var key = new GlobalKey();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => new Dialog(
              child: Container(
                width: 150,
                height: 100,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(msg, style: TextStyle(fontSize: 18))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HistoryPage(key, place)));
                              },
                              child: Text("Arrived")),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(MovingDialog);
                            },
                            child: Text("Go to map"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  static void hideMovingDialog(BuildContext context) {
    Navigator.of(context).pop(MovingDialog);
  }
}
