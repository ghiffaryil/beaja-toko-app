import 'dart:convert';

class GetOrderByStatusRequestModel {
  int orderStatus;

  GetOrderByStatusRequestModel({
    required this.orderStatus,
  });

  factory GetOrderByStatusRequestModel.fromJson(String str) =>
      GetOrderByStatusRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetOrderByStatusRequestModel.fromMap(Map<String, dynamic> json) =>
      GetOrderByStatusRequestModel(
        orderStatus: json["order_status"],
      );

  Map<String, dynamic> toMap() => {
        "order_status": orderStatus,
      };
}
