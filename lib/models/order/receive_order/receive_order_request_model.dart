import 'dart:convert';

class ReceiveOrderRequestModel {
  int orderId;

  ReceiveOrderRequestModel({
    required this.orderId,
  });

  factory ReceiveOrderRequestModel.fromJson(String str) =>
      ReceiveOrderRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReceiveOrderRequestModel.fromMap(Map<String, dynamic> json) =>
      ReceiveOrderRequestModel(
        orderId: json["order_id"],
      );

  Map<String, dynamic> toMap() => {
        "order_id": orderId,
      };
}
