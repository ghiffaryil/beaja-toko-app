import 'dart:convert';

class CreateItemResponseModel {
  String message;
  Data dataItem;

  CreateItemResponseModel({
    required this.message,
    required this.dataItem,
  });

  factory CreateItemResponseModel.fromJson(String str) =>
      CreateItemResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateItemResponseModel.fromMap(Map<String, dynamic> json) =>
      CreateItemResponseModel(
        message: json["message"],
        dataItem: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": dataItem.toMap(),
      };
}

class Data {
  int id;
  int userId;
  String sku;
  String namaItem;
  String image;
  String jenisItem;
  String volume;
  int harga;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.userId,
    required this.sku,
    required this.namaItem,
    required this.image,
    required this.jenisItem,
    required this.volume,
    required this.harga,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["ID"],
        userId: json["user_id"],
        sku: json["sku"],
        namaItem: json["nama_item"],
        image: json["image"],
        jenisItem: json["jenis_item"],
        volume: json["volume"],
        harga: json["harga"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "user_id": userId,
        "sku": sku,
        "nama_item": namaItem,
        "image": image,
        "jenis_item": jenisItem,
        "volume": volume,
        "harga": harga,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
      };
}
