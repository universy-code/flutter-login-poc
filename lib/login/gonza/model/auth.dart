class User {
  final String mail;
  final String password;

  User(this.mail, this.password);

  Map<String, String> toJson() {
    return {"mail": mail, "password": password};
  }
}

class Token {
  final String mail;
  final String token;

  Token({this.mail, this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(mail: json['mail'], token: json['token']);
  }
}
