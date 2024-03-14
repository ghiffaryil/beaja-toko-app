import 'dart:convert';

class FinishOrderRequestModel {
  int orderId;

  FinishOrderRequestModel({
    required this.orderId,
  });

  factory FinishOrderRequestModel.fromJson(String str) =>
      FinishOrderRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinishOrderRequestModel.fromMap(Map<String, dynamic> json) =>
      FinishOrderRequestModel(
        orderId: json["order_id"],
      );

  Map<String, dynamic> toMap() => {
        "order_id": orderId,
      };
}
