import 'package:flutter_application_1/src/firebase/firebase-auth.dart';

class LoginBloc {
  var _firAuth = FireAuth();

  void signUp(String username, String pass, String phone, String name,
      Function onSuccess, Function(String) onSignUpError) {
    _firAuth.signUp(username, pass, phone, name, onSuccess, onSignUpError);
  }

  void signIn(String username, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(username, pass, onSuccess, onSignInError);
  }
}
