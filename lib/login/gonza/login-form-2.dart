import 'package:flutter/material.dart';
import 'package:flutter_app/login/gonza/custom/widgets/button.dart';
import 'package:flutter_app/login/gonza/custom/widgets/edgepadded.dart';
import 'package:flutter_app/login/gonza/custom/widgets/text.dart';
import 'package:flutter_app/login/gonza/home/home-page.dart';
import 'package:flutter_app/login/gonza/http/endpoint.dart';
import 'package:flutter_app/login/gonza/model/auth.dart';

// Define a Custom Form Widget
class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: HorizontalSymmetricEdgePaddedWidget(
          paddingValue: 25.0,
          child: Column(
            children: <Widget>[
              TopOnlyEdgePaddedWidget(
                  padding: 12.0, child: CustomText('Iniciar sesión')),
              VerticalSymmetricEdgePaddedWidget(
                paddingValue: 6.0,
                child: CustomTextFormField(
                    controller: _userController,
                    inputMessage: 'Ingresá tu usuario',
                    errorMessage: 'El usuario es requerido.'),
              ),
              VerticalSymmetricEdgePaddedWidget(
                paddingValue: 6.0,
                child: CustomTextFormField(
                    controller: _passwordController,
                    inputMessage: 'Ingresá tu contraseña',
                    errorMessage: 'La contraseña es requerida.',
                    obscure: true),
              ),
              VerticalSymmetricEdgePaddedWidget(
                  paddingValue: 8.0,
                  child: ButtonTheme(
                      minWidth: 150.0,
                      child: RoundedRectangleRaisedButton(
                        radius: 250,
                        onPressed: submitButtonOnPressedAction(context),
                        text: 'Ingresar',
                        color: Colors.amber,
                      )))
            ],
          ),
        ));
  }

  VoidCallback submitButtonOnPressedAction(BuildContext context) {
    return () async {
      if (_formKey.currentState.validate()) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Verificando información.' + _userController.text)));

        try {
          User user = getUserFromTextFields();
          AuthEndpoint endpoint = AuthEndpoint(user);

          Token token = await endpoint.authorize();
          navigateToHomeScreen(token, context);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Error en la autenticacion: ' + e.toString())));
        }
      }
    };
  }

  void navigateToHomeScreen(Token token, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage(token)));
  }

  User getUserFromTextFields() {
    return User(_userController.text.trim(), _passwordController.text.trim());
  }
}
