import 'package:flutter/material.dart';
import 'package:flutter_app/login/gonza/custom/widgets/edgepadded.dart';
import 'package:flutter_app/login/gonza/custom/widgets/text.dart';
import 'package:flutter_app/login/gonza/http/endpoint.dart';
import 'package:flutter_app/login/gonza/model/auth.dart';
import 'package:flutter_app/login/gonza/model/student.dart';

class HomePage extends StatelessWidget {
  final Token _token;

  HomePage(this._token, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome !"),
        ),
        body: Center(
            child: new FutureBuilder(
                future: getStudentData(context), builder: buildStudentData())));
  }

  AsyncWidgetBuilder<Student> buildStudentData() {
    return (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data != null) {
          return buildColumn(context, snapshot.data);
        }
      } else {
        return new CircularProgressIndicator();
      }
    };
  }

  Column buildColumn(BuildContext context, Student student) {
    return Column(children: <Widget>[
      TopOnlyEdgePaddedWidget(
          padding: 12.0, child: CustomText('Name: ' + student.name)),
      TopOnlyEdgePaddedWidget(
          padding: 12.0, child: CustomText('Lastname: ' + student.lastName)),
      RaisedButton(
          child: Text('To log in.'),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
  }

  Future<Student> getStudentData(BuildContext context) {
    try {
      StudentDataEndpoint endpoint = StudentDataEndpoint(_token);
      return endpoint.getStudent();
    } catch (e) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Error al traer el perfil: ' + e.toString())));
      throw e;
    }
  }
}
