import 'package:flutter_application_1/src/firebase/firebase-auth.dart';

class LoginBloc {
  var _firAuth = FireAuth();
  // StreamController _userController = new StreamController();
  // StreamController _passContr)oller = new StreamController();

  // Stream get userStream => _userController.stream;
  // Stream get passStream => _passController.stream;

  // bool isValidInfo(String username, String pass) {
  //   if (!Validation.isValidUser(username)) {
  //     _userController.sink.addError("Username is invalid");
  //     return false;
  //   }
  //   _userController.sink.add("OK");
  //   if (!Validation.isValidPass(pass)) {
  //     _passController.sink.addError("Password is invalid");
  //     return false;
  //   }
  //   _passController.sink.add("OK");
  //   return true;
  // }

  // void dispose() {
  //   _userController.close();
  //   _passController.close();
  // }
  void signUp(String username, String pass, String phone, String name,
      Function onSuccess, Function(String) onSignUpError) {
    _firAuth.signUp(username, pass, phone, name, onSuccess, onSignUpError);
  }

  void signIn(String username, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(username, pass, onSuccess, onSignInError);
  }
}
