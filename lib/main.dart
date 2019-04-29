import 'package:flutter/material.dart';
import 'package:flutter_app/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Login(),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
