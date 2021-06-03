import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/src/resources/widget/home_menu.dart';
import 'package:flutter_application_1/src/resources/widget/map_render.dart';
import 'package:wemapgl/wemapgl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              MapRender(),
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
                  ],
                ),
              ),
            ],
          ),
        ),
        //Text("${fromPlace!.placeName}"),
        drawer: Drawer(
          child: HomeMenu(),
        ));
  }
}
