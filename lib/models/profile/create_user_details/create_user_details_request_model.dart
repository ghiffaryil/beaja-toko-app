import 'package:image_picker/image_picker.dart';

class CreateUserDetailsRequestModel {
  final String userId;
  final String statusPhone;
  final String namaDepan;
  final String namaTengah;
  final String namaBelakang;
  final String phone;
  final String alamatLengkap;
  final String provinsi;
  final String kecamatan;
  final String desa;
  final String rt;
  final String rw;
  final String noRumah;
  final String kodePos;
  final String lat;
  final String long;
  final String nik;
  final String namaToko;
  final String nib;
  final XFile? image;

  CreateUserDetailsRequestModel({
    required this.userId,
    required this.statusPhone,
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
    required this.namaToko,
    required this.nib,
    required this.image,
  });

  Map<String, String> toFormData() {
    final Map<String, String> formData = {
      'user_id': userId.toString(),
      'status_phone': statusPhone,
      'nama_depan': namaDepan,
      'nama_tengah': namaTengah,
      'nama_belakang': namaBelakang,
      'phone': phone,
      'alamat_lengkap': alamatLengkap,
      'provinsi': provinsi,
      'kecamatan': kecamatan,
      'desa': desa,
      'rt': rt,
      'rw': rw,
      'no_rumah': noRumah,
      'kode_pos': kodePos,
      'lat': lat,
      'long': long,
      'nik': nik,
      'nama_toko': namaToko,
      'nib': nib,
    };

    // If image is not null, add it to formData as a string representation
    if (image != null) {
      formData['image'] = image!.path; // Assuming image is a file path
      // print(formData);
    }

    return formData;
  }
}
