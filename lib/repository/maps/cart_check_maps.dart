// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CheckMapsRepository {
  // SET DATA LOCAL
  Future<bool> addCheckMaps(int loadMap, bool alreadyLoad) async {
    final prefs = await SharedPreferences.getInstance();

    // Save the user data including access token and user ID
    final cartMap = {
      'load_map': loadMap,
      'already_load': alreadyLoad,
    };

    final jsonString = json.encode(cartMap);
    final result = await prefs.setString('cart_check_maps', jsonString);

    // final result = await prefs.setString('auth', data.toJson());
    print(jsonString);
    return result;
  }

  // GET TOKEN
  Future<Map<String, dynamic>> getCartCheckMaps() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cart_check_maps') ?? '';
    if (jsonString.isEmpty) {
      return {};
    } else {
      final cartToko = json.decode(jsonString) as Map<String, dynamic>;
      return cartToko;
    }
  }

  // REMOVE DATA LOCAL
  Future<bool> removeCheckMaps() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('cart_check_maps');
    print('Remove Cart User Data');
    return result;
  }
}
