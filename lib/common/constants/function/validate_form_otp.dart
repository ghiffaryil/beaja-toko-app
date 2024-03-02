import 'package:flutter/material.dart';
import 'package:beaja_toko/common/constants/function/show_toast.dart';

bool validateOtpForm(List<TextEditingController> controllers) {
  if (controllers.any((controller) => controller.text.isEmpty)) {
    showToast(message: 'Masukkan Kode OTP!');
    return false;
  } else {
    return true;
  }
}
