import 'dart:convert';

class GetItemRequestModel {
  int userId;

  GetItemRequestModel({
    required this.userId,
  });

  factory GetItemRequestModel.fromRawJson(String str) =>
      GetItemRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetItemRequestModel.fromJson(Map<String, dynamic> json) =>
      GetItemRequestModel(
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
      };
}
