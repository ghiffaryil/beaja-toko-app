import 'dart:convert';

class LogoutRequestModel {
  String email;

  LogoutRequestModel({
    required this.email,
  });

  factory LogoutRequestModel.fromRawJson(String str) =>
      LogoutRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LogoutRequestModel.fromJson(Map<String, dynamic> json) =>
      LogoutRequestModel(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
