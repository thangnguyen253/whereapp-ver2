import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/resources/widget/home_menu.dart';
import 'package:flutter_application_1/src/resources/widget/ride_picker.dart';

import 'package:wemapgl/wemapgl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  late WeMapController mapController;
  int searchType = 1; //Type of search bar
  String searchInfoPlace = "Tìm kiếm ở đây"; //Hint text for InfoBar
  LatLng myLatLng = LatLng(21.038282, 105.782885);
  bool reverse = true;
  WeMapPlace? place;

  void _onMapCreated(WeMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            WeMap(
              onMapClick: (point, latlng, _place) async {
                place = _place;
              },
              onPlaceCardClose: () {
                // print("Place Card closed");
              },
              reverse: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(21.036029, 105.782950),
                zoom: 16.0,
              ),
              destinationIcon: "/flutter_application_1/assets/pin.png",
            ),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Column(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      title: Text(
                        "WhereApp",
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: TextButton(
                        onPressed: () {
                          print("Click");
                          // Scaffold.of(context).openDrawer();
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: Image.asset("menu.png"),
                      ),
                      actions: <Widget>[Image.asset("notification.png")],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: RidePicker(),
                    )
                  ],
                ))
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }
}
