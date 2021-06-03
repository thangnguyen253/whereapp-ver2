import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/firebase/firebase-auth.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  FirebaseAuth auth = FirebaseAuth.instance;

  void signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Image.asset("user.png"),
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Image.asset("history.png"),
          title: Text(
            "History",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Image.asset("menu_notify.png"),
          title: Text(
            "Notification",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Image.asset("percentage.png"),
          title: Text(
            "Discount / Coupon",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Image.asset("help.png"),
          title: Text(
            "Help",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        // ListTile(
        //   leading: Image.asset("log-out.png"),
        // title: Text(
        //  "Sign out",
        //  style: TextStyle(fontSize: 18, color: Color(0xff323643)),
        //   ),
        GestureDetector(
          onTap: signOut,
          child: ListTile(
            leading: Image.asset("log-out.png"),
            title: Text(
              "Sign out",
              style: TextStyle(fontSize: 18, color: Color(0xff323643)),
            ),
          ),
        ),
      ],
    );
  }
}
