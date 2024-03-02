import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:flutter/material.dart';

class ButtonSubmitCreateUserDetails extends StatefulWidget {
  const ButtonSubmitCreateUserDetails({super.key});

  @override
  State<ButtonSubmitCreateUserDetails> createState() =>
      _ButtonSubmitCreateUserDetailsState();
}

class _ButtonSubmitCreateUserDetailsState
    extends State<ButtonSubmitCreateUserDetails> {
  @override
  Widget build(BuildContext context) {
    return ButtonFilled.primary(
      text: 'Daftar',
      onPressed: () {},
      textColor: AppColors.white,
      fontSize: 20,
    );
  }
}
