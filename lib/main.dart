import 'package:flutter/material.dart';
import './login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //  backgroundColor: Colors.amberAccent,
        body: Login(),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
