import 'package:beaja_toko/common/constants/function/show_toast.dart';

bool validatePasswordForm(String password) {
  password = password.trim();

  if (password.isEmpty) {
    showToast(message: 'Masukkan Password');
    return false;
  }

  return true;
}
