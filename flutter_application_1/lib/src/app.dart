import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/resources/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: LoginPage(),
    );
  }
  // class MyApp extends InheritedWidget {
  // final LoginBloc authBloc;
  // final Widget child;
  // MyApp(this.authBloc, this.child) : super(child: child);

  // @override
  // bool updateShouldNotify(covariant InheritedWidget oldWidget) {
  //   // throw UnimplementedError();
  //   return false;
  // }

  // static MyApp of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<MyApp>();
  // }
// }
}
