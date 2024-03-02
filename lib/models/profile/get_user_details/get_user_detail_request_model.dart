import 'dart:convert';

class GetUserDetailRequestModel {
  String email;

  GetUserDetailRequestModel({
    required this.email,
  });

  factory GetUserDetailRequestModel.fromRawJson(String str) =>
      GetUserDetailRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUserDetailRequestModel.fromJson(Map<String, dynamic> json) =>
      GetUserDetailRequestModel(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
