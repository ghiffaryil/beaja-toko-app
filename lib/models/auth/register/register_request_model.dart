import 'dart:convert';

class RegisterRequestModel {
  String email;
  String password;
  bool isAdmin;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.isAdmin,
  });

  factory RegisterRequestModel.fromRawJson(String str) =>
      RegisterRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        email: json["email"],
        password: json["password"],
        isAdmin: json["is_admin"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "is_admin": isAdmin,
      };
}
