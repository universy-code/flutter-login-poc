import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Define a Custom Form Widget
class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Define a corresponding State class. This class will hold the data related to
// the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Iniciar sesión',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54,fontSize: 25),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  controller: _userController,
                  decoration: InputDecoration(labelText: 'Ingresá tu usuario'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'El usuario es requerido.';
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Ingresá tu contraseña'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'La contraseña es requerida.';
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ButtonTheme(
                      minWidth: 150.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(250)),
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {

                            // If the form is valid, we want to show a Snackbar
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Verificando información.'+_passwordController.text)));
                            var response = sendUser(_userController.text, _passwordController.text);
                            response.then((token)=> Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Token:'+token.token))));

                          }
                        },
                        child: Text('Ingresar'),
                        color: Colors.amber,
                      )))
            ],
          ),
        ));
  }


}

Future<Token> sendUser(String user, String password) async {
  String url = "https://2hebr2v925.execute-api.sa-east-1.amazonaws.com/qa/universy/logon";
  Map<String,String> bodyMap = {"mail": user, "password": password};
  var body = json.encode(bodyMap);
  var headers = {'x-api-key': 'XsWv3DIvGb4ZI86LpxFID4J7ZAyPp8BI7s5fXU0e', 'Content-type': 'application/json'};

  final response = await http.post(url,
      headers: headers,
      body: body);

  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load student');
  }
}


class Token {
  final String username;
  final String token;

  Token({this.username, this.token});

  factory Token.fromJson(Map<String, dynamic> json){
    return Token(
        username: json['username'],
        token: json['token']
    );
  }
}


