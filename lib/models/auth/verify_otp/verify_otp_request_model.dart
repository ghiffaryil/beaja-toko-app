import 'dart:convert';

class VerifyOtpRequestModel {
  String email;
  String otp;

  VerifyOtpRequestModel({
    required this.email,
    required this.otp,
  });

  factory VerifyOtpRequestModel.fromRawJson(String str) =>
      VerifyOtpRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      VerifyOtpRequestModel(
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
      };
}
