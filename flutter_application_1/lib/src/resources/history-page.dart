import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/model/directionHistory.dart';
import 'package:flutter_application_1/src/resources/dialog/moving-dialog.dart';
import 'package:flutter_application_1/src/resources/history-route.dart';

class HistoryPage extends StatelessWidget {
  final DirectionHistory placeAdd;
  final List<DirectionHistory> places = <DirectionHistory>[];
  HistoryPage(Key? key, this.placeAdd) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //  List<DirectionHistory> pl = <DirectionHistory>[];
    places.add(placeAdd);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(MovingDialog);
              }),
          backgroundColor: Colors.lightBlueAccent,
          elevation: 0.0,
          title: Text(
            "History",
            style: TextStyle(color: Colors.white),
          )),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return _buildList(places[index], context);
        },
      ),
    );
  }

  Widget _buildList(DirectionHistory place, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            // BoxShadow(
            //   color: Color(0x88999999),
            //   offset: Offset(0, 5),
            //   blurRadius: 5.0,
            // ),
          ]),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DirectionAPI(
                            place.fromLat,
                            place.fromLng,
                            place.toLat,
                            place.toLng,
                            place.type)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Image.asset("pin.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        "${placeAdd.from}",
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DirectionAPI(
                            place.fromLat,
                            place.fromLng,
                            place.toLat,
                            place.toLng,
                            place.type)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Image.asset("arrow.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        "${placeAdd.to}",
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DirectionAPI(
                            place.fromLat,
                            place.fromLng,
                            place.toLat,
                            place.toLng,
                            place.type)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                      height: 40,
                      child: Center(
                        child: Image.asset("vietnam.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        "${placeAdd.price.toInt().round()}đ",
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
