import 'dart:convert';

class GetUserDetailsResponseModel {
  int id;
  String email;
  String password;
  bool statusEmail;
  bool isAdmin;
  bool isLogin;
  DateTime createdAt;
  DateTime updatedAt;
  List<UserDetail> userDetail;

  GetUserDetailsResponseModel({
    required this.id,
    required this.email,
    required this.password,
    required this.statusEmail,
    required this.isAdmin,
    required this.isLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.userDetail,
  });

  factory GetUserDetailsResponseModel.fromJson(String str) =>
      GetUserDetailsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetUserDetailsResponseModel.fromMap(Map<String, dynamic> json) =>
      GetUserDetailsResponseModel(
        id: json["ID"],
        email: json["email"],
        password: json["password"],
        statusEmail: json["status_email"],
        isAdmin: json["is_admin"],
        isLogin: json["is_login"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        userDetail: List<UserDetail>.from(
            json["UserDetail"].map((x) => UserDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "email": email,
        "password": password,
        "status_email": statusEmail,
        "is_admin": isAdmin,
        "is_login": isLogin,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "UserDetail": List<dynamic>.from(userDetail.map((x) => x.toMap())),
      };
}

class UserDetail {
  int id;
  int userId;
  String namaDepan;
  String namaTengah;
  String namaBelakang;
  String nik;
  String namaToko;
  String nib;
  String phone;
  String noHp;
  String image;
  String provinsi;
  String kecamatan;
  String desa;
  String rt;
  String rw;
  String noRumah;
  String alamatLengkap;
  String kodePos;
  String lat;
  String long;
  DateTime createdAt;
  DateTime updatedAt;

  UserDetail({
    required this.id,
    required this.userId,
    required this.namaDepan,
    required this.namaTengah,
    required this.namaBelakang,
    required this.nik,
    required this.namaToko,
    required this.nib,
    required this.phone,
    required this.noHp,
    required this.image,
    required this.provinsi,
    required this.kecamatan,
    required this.desa,
    required this.rt,
    required this.rw,
    required this.noRumah,
    required this.alamatLengkap,
    required this.kodePos,
    required this.lat,
    required this.long,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetail.fromJson(String str) =>
      UserDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDetail.fromMap(Map<String, dynamic> json) => UserDetail(
        id: json["ID"],
        userId: json["user_id"],
        namaDepan: json["nama_depan"],
        namaTengah: json["nama_tengah"],
        namaBelakang: json["nama_belakang"],
        nik: json["nik"],
        namaToko: json["nama_toko"],
        nib: json["nib"],
        phone: json["phone"],
        noHp: json["no_hp"],
        image: json["image"],
        provinsi: json["provinsi"],
        kecamatan: json["kecamatan"],
        desa: json["desa"],
        rt: json["rt"],
        rw: json["rw"],
        noRumah: json["no_rumah"],
        alamatLengkap: json["alamat_lengkap"],
        kodePos: json["kode_pos"],
        lat: json["lat"],
        long: json["long"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "user_id": userId,
        "nama_depan": namaDepan,
        "nama_tengah": namaTengah,
        "nama_belakang": namaBelakang,
        "nik": nik,
        "nama_toko": namaToko,
        "nib": nib,
        "phone": phone,
        "no_hp": noHp,
        "image": image,
        "provinsi": provinsi,
        "kecamatan": kecamatan,
        "desa": desa,
        "rt": rt,
        "rw": rw,
        "no_rumah": noRumah,
        "alamat_lengkap": alamatLengkap,
        "kode_pos": kodePos,
        "lat": lat,
        "long": long,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
      };
}
