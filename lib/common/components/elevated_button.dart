import 'package:flutter/material.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';

class ButtonFilled extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final bool loading;
  final IconData? iconData; // Icon data to be displayed

  const ButtonFilled.primary({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.iconData,
  });

  const ButtonFilled.secondary({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.secondary,
    this.textColor = AppColors.white,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.iconData,
  });

  const ButtonFilled.success({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.success,
    this.textColor = AppColors.success,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.iconData,
  });

  const ButtonFilled.info({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.info,
    this.textColor = AppColors.info,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.iconData,
  });

  const ButtonFilled.warning({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.warning,
    this.textColor = AppColors.warning,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.iconData,
  });

  const ButtonFilled.light({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.light,
    this.textColor = AppColors.light,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.iconData,
  });

  const ButtonFilled.white({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.white,
    this.textColor = AppColors.primary,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.iconData,
  });

  const ButtonFilled.custom({
    super.key,
    required this.text,
    this.rounded = true,
    required this.backgroundColor,
    required this.textColor,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(MediaQuery.of(context).size.width * width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
          ),
        ),
        onPressed: onPressed,
        child: loading
            ? SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(
                    color: textColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconData != null) Icon(iconData, color: textColor),
                  SizedBox(width: iconData != null ? 8.0 : 0),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ButtonOutlined extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color borderColor;
  final Color textColor;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool loading;

  const ButtonOutlined.primary({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.primary,
    this.textColor = AppColors.primary,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.secondary({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.secondary,
    this.textColor = AppColors.secondary,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.warning({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.warning,
    this.textColor = AppColors.warning,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.info({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.info,
    this.textColor = AppColors.info,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.success({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.success,
    this.textColor = AppColors.success,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.light({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.light,
    this.textColor = AppColors.light,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.white({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.primary,
    this.textColor = AppColors.primary,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor = AppColors.bg,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * width, height),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: loading
          ? CircularProgressIndicator(
              color: textColor,
            )
          : Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            ),
    );
  }
}
