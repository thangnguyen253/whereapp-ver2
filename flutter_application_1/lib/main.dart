// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/app.dart';
import 'package:wemapgl/wemapgl.dart' as WEMAP;
import 'package:location/location.dart';

void main() async {
  final location = Location();
  final hasPermissions = await location.hasPermission();
  if (hasPermissions != PermissionStatus.granted) {
    await location.requestPermission();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WEMAP.Configuration.setWeMapKey('GqfwrZUEfxbwbnQUhtBMFivEysYIxelQ');
  runApp(MyApp());
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp(
//       new LoginBloc(),
//       MaterialApp(
//         home: LoginPage(),
//       )));
// }
