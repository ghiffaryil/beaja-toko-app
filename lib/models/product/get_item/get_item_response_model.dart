import 'dart:convert';

class GetItemResponseModel {
  String message;
  List<ListItem> data;

  GetItemResponseModel({
    required this.message,
    required this.data,
  });

  factory GetItemResponseModel.fromJson(String str) =>
      GetItemResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetItemResponseModel.fromMap(Map<String, dynamic> json) =>
      GetItemResponseModel(
        message: json["message"],
        data: List<ListItem>.from(json["data"].map((x) => ListItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class ListItem {
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

  ListItem({
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

  factory ListItem.fromJson(String str) => ListItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListItem.fromMap(Map<String, dynamic> json) => ListItem(
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
