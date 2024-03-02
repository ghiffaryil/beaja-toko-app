import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beaja_toko/bloc/auth/login/auth_login_bloc.dart';
import 'package:beaja_toko/bloc/auth/verify_otp/verify_otp_bloc.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/function/show_toast.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/models/auth/login/login_request_model.dart';
import 'package:beaja_toko/models/auth/verify_otp/verify_otp_request_model.dart';
import 'package:beaja_toko/pages/auth/create_user_details/create_user_details.dart';
import 'package:beaja_toko/pages/auth/login/login.dart';

class ButtonSubmitVerificationOtp extends StatefulWidget {
  final String inputEmail;
  final String inputPassword;
  final String otpCode;

  const ButtonSubmitVerificationOtp({
    super.key,
    required this.inputEmail,
    required this.inputPassword,
    required this.otpCode,
  });

  @override
  State<ButtonSubmitVerificationOtp> createState() =>
      _ButtonSubmitVerificationOtpState();
}

class _ButtonSubmitVerificationOtpState
    extends State<ButtonSubmitVerificationOtp> {
  @override
  Widget build(BuildContext context) {
    // print(widget.otpCode);
    return BlocListener<VerifyOtpBloc, VerifyOtpState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showDialogModalLogin();
                },
                barrierDismissible: false,
              );
            },
            error: (msg) {
              showToast(message: 'Tidak dapat memverifikasi OTP');
            });
      },
      child: BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return ButtonFilled.primary(
                  text: 'Verifikasi',
                  onPressed: () {
                    final requestModel = VerifyOtpRequestModel(
                      email: widget.inputEmail,
                      otp: widget.otpCode,
                    );
                    context
                        .read<VerifyOtpBloc>()
                        .add(VerifyOtpEvent.verifyOtp(requestModel));
                  });
            },
            loading: () {
              return ButtonFilled.primary(
                text: '',
                loading: true,
                onPressed: () {},
                textColor: AppColors.white,
              );
            },
          );
        },
      ),
    );
  }

  Widget showDialogModalLogin() {
    return BlocListener<AuthLoginBloc, AuthLoginState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const CreateUserDetails();
              }));
            },
            error: (msg) {
              showToast(message: msg);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            });
      },
      child: BlocBuilder<AuthLoginBloc, AuthLoginState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return AlertDialog(
                surfaceTintColor: AppColors.white,
                title: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Selamat!',
                    style: TextStyles.h3(color: AppColors.bg),
                    textAlign: TextAlign.center,
                  ),
                ),
                content: Text(
                  'Email anda telah berhasil diverifikasi',
                  textAlign: TextAlign.center,
                  style: TextStyles.h5(color: AppColors.bg),
                ),
                actions: [
                  ButtonFilled.primary(
                      text: 'Lanjutkan',
                      onPressed: () {
                        final requestModel = LoginRequestModel(
                          email: widget.inputEmail,
                          password: widget.inputPassword,
                        );
                        context
                            .read<AuthLoginBloc>()
                            .add(AuthLoginEvent.login(requestModel));
                      }),
                ],
              );
            },
            loading: () {
              return AlertDialog(
                surfaceTintColor: AppColors.white,
                content: SizedBox(
                  height: 100,
                  width: 100,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
