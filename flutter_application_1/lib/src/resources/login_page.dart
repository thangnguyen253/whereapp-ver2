import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/login_bloc.dart';
import 'package:flutter_application_1/src/resources/dialog/loading_dialog.dart';
import 'package:flutter_application_1/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_application_1/src/resources/home_page.dart';
import 'package:flutter_application_1/src/resources/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc authBloc = new LoginBloc();

  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  var _userNameErr = "Username is invalid";
  var _passErr = "Password is invalid";
  var _userInvalid = false;
  var _passInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                    child: FlutterLogo(),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                  child: Text("Hello, Welcome to WhereApp",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  controller: _userController,
                  decoration: InputDecoration(
                      labelText: "USERNAME",
                      errorText: _userInvalid ? _userNameErr : null,
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      controller: _passController,
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                          labelText: "PASSWORD",
                          errorText: _passInvalid ? _passErr : null,
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 15)),
                    ),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Text(
                        _showPass ? "HIDE" : "SHOW",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.lightBlueAccent)),
                  onPressed: onSignInClicked,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Container(
                height: 130,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "New user? ",
                      style: TextStyle(fontSize: 15, color: Color(0xff888888)),
                    ),
                    GestureDetector(
                        onTap: onToggleSignUp,
                        child: Text(
                          "Sign Up here!",
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSignInClicked() {
    setState(() {
      if (_userController.text.length < 6 &&
          _userController.text.contains("@")) {
        _userInvalid = true;
      } else
        _userInvalid = false;

      if (_passController.text.length < 8) {
        _passInvalid = true;
      } else
        _passInvalid = false;

      if (!_userInvalid && !_passInvalid) {
        LoadingDialog.showLoadingDialog(context, "Waiting...");
        authBloc.signIn(_userController.text, _passController.text, () {
          LoadingDialog.hideLoadingDialog(context);
          Navigator.push(context, MaterialPageRoute(builder: gotoHome));
        }, (msg) {
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, "Sign in", msg);
        });
      }
    });
  }

  void onToggleSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: gotoSignUp));
  }

  Widget gotoHome(BuildContext context) {
    return HomePage();
  }

  Widget gotoSignUp(BuildContext context) {
    return RegisterPage();
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
