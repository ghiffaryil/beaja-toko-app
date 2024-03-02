// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:beaja_toko/models/auth/login/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalRepository {
  // SET DATA LOCAL
  Future<bool> saveAuthData(LoginResponseModel data) async {
    final prefs = await SharedPreferences.getInstance();

    // Save the user data including access token and user ID
    final authMap = {
      'access_token': data.token.aksesToken,
      'user_id': data.id,
      'user_email': data.email,
    };

    final jsonString = json.encode(authMap);
    final result = await prefs.setString('auth', jsonString);

    // final result = await prefs.setString('auth', data.toJson());
    return result;
  }

  // GET TOKEN
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('auth') ?? '';
    if (jsonString.isEmpty) {
      return '';
    } else {
      final authMap = json.decode(jsonString) as Map<String, dynamic>;
      if (authMap.containsKey("access_token")) {
        final accessToken = authMap['access_token'];
        return accessToken.toString();
      } else {
        return '';
      }
    }
  }

  // GET USER EMAIL
  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('auth') ?? '';
    if (jsonString.isEmpty) {
      return '';
    } else {
      final authMap = json.decode(jsonString) as Map<String, dynamic>;
      if (authMap.containsKey("user_email")) {
        final userEmail = authMap['user_email'];
        return userEmail.toString();
      } else {
        return '';
      }
    }
  }

  Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('auth') ?? '';
    if (jsonString.isEmpty) {
      return 0;
    } else {
      final authMap = json.decode(jsonString) as Map<String, dynamic>;
      if (authMap.containsKey("user_id")) {
        final userId = authMap['user_id'];
        return userId;
      } else {
        return 0;
      }
    }
  }

  // IS LOGIN?
  Future<bool> isHaveToken() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString('auth') ?? '';
    return authJson.isNotEmpty;
  }

  // REMOVE DATA LOCAL
  Future<bool> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('auth');
    print('Remove Auth Data');
    return result;
  }

  Future<bool> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final clear = await prefs.clear();
    print('Clear Auth Data');
    return clear;
  }
}
