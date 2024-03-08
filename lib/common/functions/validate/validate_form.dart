import 'package:beaja_toko/common/constants/widgets/show_toast.dart';

bool validateForm(String input, bool Function(String) validationFunction,
    String errorMessage) {
  input = input.trim();

  if (input.isEmpty) {
    showToast(message: errorMessage);
    return false;
  }

  return validationFunction(input);
}
