import 'dart:convert';
import 'package:flutter_app/login/gonza/model/auth.dart';
import 'package:flutter_app/login/gonza/model/student.dart';
import 'package:http/http.dart' as http;

class AuthEndpoint {
  final String url =
      "https://2hebr2v925.execute-api.sa-east-1.amazonaws.com/qa/universy/login";

  final User user;

  AuthEndpoint(this.user);

  dynamic getBody() {
    return json.encode(user.toJson());
  }

  dynamic getHeaders() {
    return KeyAuthHeader().toJson();
  }

  Future<Token> authorize() async {
    final response =
        await http.post(url, headers: getHeaders(), body: getBody());

    if (response.statusCode == 200) {
      return Token.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception(response.body);
    }
  }
}

class StudentDataEndpoint {
  final String _url =
      "https://2hebr2v925.execute-api.sa-east-1.amazonaws.com/qa/universy/studentdata";

  final Token _token;

  StudentDataEndpoint(this._token);

  dynamic getHeaders() {
    return TokenAuthHeader(_token).toJson();
  }

  String getEndpoint() {
    return _url + "?mail=" + _token.mail;
  }

  Future<Student> getStudent() async {
    final response = await http.get(getEndpoint(), headers: getHeaders());

    if (response.statusCode == 200) {
      return Student.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception(response.body);
    }
  }
}

class KeyAuthHeader {
  final String x_api_key = "XsWv3DIvGb4ZI86LpxFID4J7ZAyPp8BI7s5fXU0e";
  final String content_type = "application/json";

  Map<String, String> toJson() {
    return {"x-api-key": x_api_key, "Content-type": content_type};
  }
}

class TokenAuthHeader {
  final String _content_type = "application/json";
  String _token;

  TokenAuthHeader(Token token) {
    this._token = token.token;
  }

  Map<String, String> toJson() {
    return {"auth": _token, "Content-type": _content_type};
  }
}
