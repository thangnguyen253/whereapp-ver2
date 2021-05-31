import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/login_bloc.dart';
import 'package:flutter_application_1/src/resources/dialog/loading_dialog.dart';
import 'package:flutter_application_1/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_application_1/src/resources/home_page.dart';
import 'package:flutter_application_1/src/resources/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  LoginBloc authBloc = new LoginBloc();

  bool _showPass = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  var _userNameErr = "Username must be longer than 6 character";
  var _passErr = "Password must be longer than 8 character";
  var _phoneErr = "Phone number is invalid";
  var _userInvalid = false;
  var _passInvalid = false;
  var _phoneInvalid = false;

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
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 40),
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
                  child: Text("Sign Up for free!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: "NAME",
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: "PHONE NUMBER",
                      errorText: _phoneInvalid ? _phoneErr : null,
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  controller: _userController,
                  decoration: InputDecoration(
                      labelText: "EMAIL",
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
                  onPressed: onSignUpClicked,
                  child: Text(
                    "SIGN UP",
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
                        "Already have an account? ",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff888888)),
                      ),
                      GestureDetector(
                          onTap: onToggleSignIn,
                          child: Text(
                            "Login now",
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          )),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSignUpClicked() {
    setState(() {
      if (_userController.text.length < 6 &&
          !_userController.text.contains("@")) {
        _userInvalid = true;
      } else
        _userInvalid = false;

      if (_passController.text.length < 8) {
        _passInvalid = true;
      } else
        _passInvalid = false;

      if (_phoneController.text.length != 10) {
        _phoneInvalid = true;
      } else
        _phoneInvalid = false;

      if (_userInvalid == false &&
          _passInvalid == false &&
          _phoneInvalid == false) {
        LoadingDialog.showLoadingDialog(context, "Waiting...");
        authBloc.signUp(_userController.text, _passController.text,
            _phoneController.text, _nameController.text, () {
          LoadingDialog.hideLoadingDialog(context);
          Navigator.push(context, MaterialPageRoute(builder: gotoSignIn));
        }, (msg) {
          MsgDialog.showMsgDialog(context, "Sign up message", msg);
        });
      }
    });
  }

  void onToggleSignIn() {
    Navigator.push(context, MaterialPageRoute(builder: gotoSignIn));
  }

  Widget gotoSignIn(BuildContext context) {
    return LoginPage();
  }

  Widget gotoHome(BuildContext context) {
    return HomePage();
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
