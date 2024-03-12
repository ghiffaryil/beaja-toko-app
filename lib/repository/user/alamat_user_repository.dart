// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AlamatUserReporitory {
  // SET DATA LOCAL
  Future<bool> addAlamatUser(String alamatUser, String latUser, String longUser,
      String kelurahanUser, String kecamatanUser, String provinsiUser) async {
    final prefs = await SharedPreferences.getInstance();

    // Save the user data including access token and user ID
    final cartUserToMap = {
      'alamat_user': alamatUser,
      'lat_user': latUser,
      'long_user': longUser,
      'kelurahan_user': kelurahanUser,
      'kecamatan_user': kecamatanUser,
      'provinsi_user': provinsiUser,
    };

    final jsonString = json.encode(cartUserToMap);
    final result = await prefs.setString('alamat_user_repository', jsonString);

    // final result = await prefs.setString('auth', data.toJson());
    print(jsonString);
    return result;
  }

  // GET TOKEN
  Future<Map<String, dynamic>> getAlamatUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('alamat_user_repository') ?? '';
    if (jsonString.isEmpty) {
      return {};
    } else {
      final cartToko = json.decode(jsonString) as Map<String, dynamic>;
      return cartToko;
    }
  }

  // REMOVE DATA LOCAL
  Future<bool> removeAlamatUser() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('alamat_user_repository');
    print('Remove Cart User Data');
    return result;
  }
}
