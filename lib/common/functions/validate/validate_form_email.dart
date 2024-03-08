import 'package:beaja_toko/common/constants/widgets/show_toast.dart';

bool validateEmailForm(String email) {
  email = email.trim();

  if (email.isEmpty) {
    showToast(message: 'Masukkan Email kamu');
    return false;
  }

  // Regular expression for a simple email validation
  RegExp emailRegExp = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  if (!emailRegExp.hasMatch(email)) {
    showToast(message: 'Masukkan Email yang valid');
    return false;
  }

  return true;
}
