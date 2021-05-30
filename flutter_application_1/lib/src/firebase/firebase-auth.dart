import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void signUp(String username, String pass, String phone, String name,
      Function onSuccess, Function(String) onSignUpError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: username, password: pass)
        .then((user) {
      _createUser(user.user!.uid, phone, name, pass, onSuccess, onSignUpError);
      print(user);
    }).catchError((err) {
      _onSignUpErr(err.code, onSignUpError);
    });
  }

  _createUser(String userID, String phone, String name, String pass,
      Function onSuccess, Function(String) onSignUpError) {
    var user = {
      "name": name,
      "phoneNumber": phone,
    };
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userID).set(user).then((user) {
      onSuccess();
    }).catchError((err) {
      onSignUpError("Sign up failed, try again!");
    });
  }

  void signIn(String username, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: username, password: pass)
        .then((user) {
      print("on sign in success");
      onSuccess();
    }).catchError((err) {
      onSignInError("Sign in failed, try again!");
    });
  }

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("Sign up fail, please try again");
        break;
    }
  }
}
