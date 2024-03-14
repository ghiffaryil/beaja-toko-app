import 'dart:convert';

class FinishOrderResponseModel {
  String status;
  String message;
  Data data;

  FinishOrderResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FinishOrderResponseModel.fromJson(String str) =>
      FinishOrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinishOrderResponseModel.fromMap(Map<String, dynamic> json) =>
      FinishOrderResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
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
  dynamic orderDetails;

  Data({
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

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
        orderDetails: json["order_details"],
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
        "order_details": orderDetails,
      };
}
