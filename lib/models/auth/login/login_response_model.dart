import 'dart:convert';

class LoginResponseModel {
  int id;
  String email;
  bool statusEmail;
  Token token;

  LoginResponseModel({
    required this.id,
    required this.email,
    required this.statusEmail,
    required this.token,
  });

  factory LoginResponseModel.fromRawJson(String str) =>
      LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json["id"],
        email: json["email"],
        statusEmail: json["status_email"],
        token: Token.fromJson(json["Token"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "status_email": statusEmail,
        "Token": token.toJson(),
      };
}

class Token {
  String aksesToken;
  String refreshToken;

  Token({
    required this.aksesToken,
    required this.refreshToken,
  });

  factory Token.fromRawJson(String str) => Token.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        aksesToken: json["AksesToken"],
        refreshToken: json["RefreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "AksesToken": aksesToken,
        "RefreshToken": refreshToken,
      };
}
