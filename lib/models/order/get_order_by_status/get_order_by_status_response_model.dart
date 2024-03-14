import 'dart:convert';

class GetOrderByStatusResponseModel {
  String message;
  List<ListOrder> data;

  GetOrderByStatusResponseModel({
    required this.message,
    required this.data,
  });

  factory GetOrderByStatusResponseModel.fromJson(String str) =>
      GetOrderByStatusResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetOrderByStatusResponseModel.fromMap(Map<String, dynamic> json) =>
      GetOrderByStatusResponseModel(
        message: json["message"],
        data:
            List<ListOrder>.from(json["data"].map((x) => ListOrder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class ListOrder {
  int id;
  String keyOrder;
  int userId;
  int pembeliId;
  String namaPembeli;
  String pembeliLat;
  String pembeliLong;
  String alamatPembeli;
  bool delivery;
  int orderStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderDetail> orderDetails;

  ListOrder({
    required this.id,
    required this.keyOrder,
    required this.userId,
    required this.pembeliId,
    required this.namaPembeli,
    required this.pembeliLat,
    required this.pembeliLong,
    required this.alamatPembeli,
    required this.delivery,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.orderDetails,
  });

  factory ListOrder.fromJson(String str) => ListOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListOrder.fromMap(Map<String, dynamic> json) => ListOrder(
        id: json["ID"],
        keyOrder: json["key_order"],
        userId: json["user_id"],
        pembeliId: json["pembeli_id"],
        namaPembeli: json["nama_pembeli"],
        pembeliLat: json["pembeli_lat"],
        pembeliLong: json["pembeli_long"],
        alamatPembeli: json["alamat_pembeli"],
        delivery: json["delivery"],
        orderStatus: json["order_status"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        orderDetails: List<OrderDetail>.from(
            json["order_details"].map((x) => OrderDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "key_order": keyOrder,
        "user_id": userId,
        "pembeli_id": pembeliId,
        "nama_pembeli": namaPembeli,
        "pembeli_lat": pembeliLat,
        "pembeli_long": pembeliLong,
        "alamat_pembeli": alamatPembeli,
        "delivery": delivery,
        "order_status": orderStatus,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "order_details": List<dynamic>.from(orderDetails.map((x) => x.toMap())),
      };
}

class OrderDetail {
  int id;
  String keyOrder;
  int orderId;
  String sku;
  int qty;
  int harga;
  int itemId;
  DateTime createdAt;
  DateTime updatedAt;

  OrderDetail({
    required this.id,
    required this.keyOrder,
    required this.orderId,
    required this.sku,
    required this.qty,
    required this.harga,
    required this.itemId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderDetail.fromJson(String str) =>
      OrderDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromMap(Map<String, dynamic> json) => OrderDetail(
        id: json["ID"],
        keyOrder: json["key_order"],
        orderId: json["order_id"],
        sku: json["sku"],
        qty: json["QTY"],
        harga: json["harga"],
        itemId: json["item_id"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "key_order": keyOrder,
        "order_id": orderId,
        "sku": sku,
        "QTY": qty,
        "harga": harga,
        "item_id": itemId,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
      };
}
