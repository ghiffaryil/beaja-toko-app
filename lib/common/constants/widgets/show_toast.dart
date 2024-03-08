import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';

void showToast({
  required String message,
  Toast length = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int timeInSecForIosWeb = 1,
  double fontSize = 16.0,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: length,
    gravity: gravity,
    timeInSecForIosWeb: timeInSecForIosWeb,
    backgroundColor: AppColors.muted.withOpacity(0.7),
    textColor: Colors.white,
    fontSize: fontSize,
  );
}
