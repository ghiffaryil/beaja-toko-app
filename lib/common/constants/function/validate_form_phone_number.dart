import 'package:beaja_toko/common/constants/function/show_toast.dart';

bool validatePhoneNumberForm(String phoneNumber) {
  phoneNumber = phoneNumber.trim();

  if (phoneNumber.isEmpty) {
    showToast(message: 'Masukkan Nomor handphone');
    return false;
  }

  return true;
}
