import 'package:beaja_toko/common/constants/widgets/show_toast.dart';
import 'package:flutter/material.dart';

bool validateOtpForm(List<TextEditingController> controllers) {
  if (controllers.any((controller) => controller.text.isEmpty)) {
    showToast(message: 'Masukkan Kode OTP!');
    return false;
  } else {
    return true;
  }
}
