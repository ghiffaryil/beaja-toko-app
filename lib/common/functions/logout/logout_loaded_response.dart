import 'package:beaja_toko/pages/auth/login/login.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:flutter/material.dart';

void logoutLoadedFunction(BuildContext context) {
  // Remove authentication data
  AuthLocalRepository().removeAuthData();
  // Clear any remaining authentication data
  AuthLocalRepository().clearAuthData();
  // Navigate to the login page and replace the current route
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}
