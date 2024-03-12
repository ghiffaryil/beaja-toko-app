import 'dart:convert';

class UpdateUserDetailsRequestModel {
  String namaDepan;
  String namaTengah;
  String namaBelakang;
  String phone;
  String alamatLengkap;
  String provinsi;
  String kecamatan;
  String desa;
  String rt;
  String rw;
  String noRumah;
  String kodePos;
  String lat;
  String long;
  String nik;
  String nib;
  String namaToko;
  String noHp;

  UpdateUserDetailsRequestModel({
    required this.namaDepan,
    required this.namaTengah,
    required this.namaBelakang,
    required this.phone,
    required this.alamatLengkap,
    required this.provinsi,
    required this.kecamatan,
    required this.desa,
    required this.rt,
    required this.rw,
    required this.noRumah,
    required this.kodePos,
    required this.lat,
    required this.long,
    required this.nik,
    required this.nib,
    required this.namaToko,
    required this.noHp,
  });

  factory UpdateUserDetailsRequestModel.fromJson(String str) =>
      UpdateUserDetailsRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateUserDetailsRequestModel.fromMap(Map<String, dynamic> json) =>
      UpdateUserDetailsRequestModel(
        namaDepan: json["nama_depan"],
        namaTengah: json["nama_tengah"],
        namaBelakang: json["nama_belakang"],
        phone: json["phone"],
        alamatLengkap: json["alamat_lengkap"],
        provinsi: json["provinsi"],
        kecamatan: json["kecamatan"],
        desa: json["desa"],
        rt: json["rt"],
        rw: json["rw"],
        noRumah: json["no_rumah"],
        kodePos: json["kode_pos"],
        lat: json["lat"],
        long: json["long"],
        nik: json["nik"],
        nib: json["nib"],
        namaToko: json["nama_toko"],
        noHp: json["no_hp"],
      );

  Map<String, dynamic> toMap() => {
        "nama_depan": namaDepan,
        "nama_tengah": namaTengah,
        "nama_belakang": namaBelakang,
        "phone": phone,
        "alamat_lengkap": alamatLengkap,
        "provinsi": provinsi,
        "kecamatan": kecamatan,
        "desa": desa,
        "rt": rt,
        "rw": rw,
        "no_rumah": noRumah,
        "kode_pos": kodePos,
        "lat": lat,
        "long": long,
        "nik": nik,
        "nib": nib,
        "nama_toko": namaToko,
        "no_hp": noHp,
      };
}
