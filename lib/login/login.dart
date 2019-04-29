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
        child: Scaffold(
            backgroundColor: Colors.transparent, body: loginContent(context)),
      ),
    );
  }

  Center loginContent(BuildContext context) {
    return Center(
        child: ListView(
      controller: _scroll,
      children: <Widget>[
        Column(
          children: <Widget>[
            universyLogo(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Opacity(
                  opacity: 0.95,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[LoginForm(), loginFooter(context)],
                      )),
                ))
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ],
    ));
  }

  Container loginFooter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFf5f5f5),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 15.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  child: RichText(
                      text: TextSpan(
                    text: '¿Aún no tienes cuenta? ',
                    style: TextStyle(fontSize: 18, color: Colors.black45),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Crear nueva.',
                          style: TextStyle(color: Colors.blue)),
                    ],
                  )),
                  onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Aca va la redireccion a la pantalla nueva cuenta'))),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Aca va la redireccion a la pantalla de soporte para contraseña'))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row universyLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0.80,
          child: Image.asset('sources/universy-logo.png',
              width: 180, height: 145, alignment: Alignment(-1, -1)),
        )
      ],
    );
  }
}
