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
    }).catchError((err) {
      //print("err: " + err.toString());
      _onSignUpErr(err.code, onSignUpError);
      onSignUpError("err: " + err.toString());
    });
  }

  _createUser(String userID, String phone, String name, String pass,
      Function onSuccess, Function(String) onSignUpError) {
    var user = Map<String, String>();
    user["name"] = name;
    user["phoneNumber"] = phone;
    user["password"] = pass;

    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userID).set(user).then((user) {
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onSignUpError("err: " + err.toString());
    }).whenComplete(() {
      print("Completed");
    });
  }

  void signIn(String username, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: username, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      //print("err: " + err.toString());
      onSignInError("err: " + err.toString());
    });
  }

  void _onSignUpErr(String code, Function(String) onSignUpError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onSignUpError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onSignUpError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onSignUpError("The password is not strong enough");
        break;
      default:
        onSignUpError("Sign up fail, please try again");
        break;
    }

    Future<void> signOut() async {
      print("signOut");
      return _firebaseAuth.signOut();
    }
  }
}
