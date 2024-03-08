import 'dart:async';

import 'package:beaja_toko/common/components/appbar_plain.dart';
import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/functions/merge_otp_value/merge_value_otp.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/pages/auth/login/login.dart';
import 'package:beaja_toko/pages/auth/verify/widgets/button/button_submit_verification_otp.dart';
import 'package:flutter/material.dart';

class VerifyOtpPage extends StatefulWidget {
  final String inputEmail;
  final String inputPassword;

  const VerifyOtpPage({
    super.key,
    required this.inputEmail,
    required this.inputPassword,
  });

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  // String otpCode = '';

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _otpInputControllers =
      List.generate(6, (_) => TextEditingController());

  int _secondsRemaining = 59; // Initial value for the countdown timer
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (int i = 0; i < 6; i++) {
      _focusNodes[i].dispose();
      _otpInputControllers[i].dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        leadingIcon: Icons.arrow_back_ios,
        iconColor: AppColors.primary,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LoginPage();
          }));
        },
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: CustomPadding.px2,
              alignment: Alignment.centerLeft,
              child: Text(
                '2. Verifikasi OTP',
                style: TextStyles.h2(color: AppColors.primary),
              ),
            ),
            Container(
              padding: CustomPadding.p2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  formInputOTP(),
                  CustomDividers.smallDivider(),
                  // FormResetOTP(),
                  CustomDividers.smallDivider(),
                  CustomDividers.smallDivider(),
                  ButtonSubmitVerificationOtp(
                    inputEmail: widget.inputEmail,
                    inputPassword: widget.inputPassword,
                    otpCode: mergeOtpValue(_otpInputControllers),
                  ),
                  CustomDividers.smallDivider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formInputOTP() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Masukkan 6 digit angka OTP dari Email kamu',
            style: TextStyles.h4(color: AppColors.primary),
          ),
        ),
        CustomDividers.smallDivider(),
        CustomDividers.smallDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return Container(
              width: 55.0,
              height: 65.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.primary,
                    width: 1.0), // Add your border color
              ),
              child: TextFormField(
                style: TextStyles.h3(color: AppColors.primary),
                controller: _otpInputControllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (index < 5) {
                      FocusScope.of(context)
                          .requestFocus(_focusNodes[index + 1]);
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  }
                },
                decoration: const InputDecoration(
                  counterText: '',
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
