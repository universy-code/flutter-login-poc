import 'dart:convert';
import 'package:http/http.dart' as http;

class Endpoint {
  final String url =
      "https://2hebr2v925.execute-api.sa-east-1.amazonaws.com/qa/universy/logon";

  final User user;

  Endpoint(this.user);

  dynamic getBody(){
    Map<String, String> bodyMap = {"mail": user.mail, "password": user.password}; //Try with object
    return json.encode(bodyMap);
  }

  dynamic getHeaders(){
    return {
      'x-api-key': 'XsWv3DIvGb4ZI86LpxFID4J7ZAyPp8BI7s5fXU0e', //here to, try with objects!
      'Content-type': 'application/json'
    };
  }

  Future<Token> post() async{
    final response = await http.post(url, headers: getHeaders(), body: getBody());

    if (response.statusCode == 200) {
      return Token.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load student');
    }
  }

}

class User {
  final String mail;
  final String password;

  User(this.mail, this.password);
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



Future<Token> sendUser(String user, String password) async {
  String url =
      "https://2hebr2v925.execute-api.sa-east-1.amazonaws.com/qa/universy/logon";
  Map<String, String> bodyMap = {"mail": user, "password": password};
  var body = json.encode(bodyMap);
  var headers = {
    'x-api-key': 'XsWv3DIvGb4ZI86LpxFID4J7ZAyPp8BI7s5fXU0e',
    'Content-type': 'application/json'
  };

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load student');
  }
}
