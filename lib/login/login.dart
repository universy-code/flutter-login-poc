import 'package:flutter/material.dart';
import 'login-form.dart';

class Login extends StatelessWidget {
  ScrollController _scroll = new ScrollController();
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    _scroll = new ScrollController();
    _focus.addListener(() {
      _scroll.jumpTo(-1.0);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('sources/main-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:
            Scaffold(backgroundColor: Colors.transparent, body: loginContent()),
      ),
    );
  }

  Center loginContent() {
    return Center(
        child: ListView(
      controller: _scroll,
      children: <Widget>[
        Column(
          children: <Widget>[
            universyLogo(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.white,
                child: LoginForm(),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ],
    ));
  }

  Row universyLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('sources/universy-logo.png',
            width: 180, height: 145, alignment: Alignment(-1, -1)),
      ],
    );
  }
}
