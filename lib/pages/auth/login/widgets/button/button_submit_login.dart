import 'package:beaja_toko/bloc/auth/login/auth_login_bloc.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/widgets/show_toast.dart';
import 'package:beaja_toko/common/functions/validate/validate_form_email.dart';
import 'package:beaja_toko/common/functions/validate/validate_form_password.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/models/auth/login/login_request_model.dart';
import 'package:beaja_toko/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonSubmitLogin extends StatefulWidget {
  final String Function() getInputEmail;
  final String Function() getInputPassword;

  const ButtonSubmitLogin({
    super.key,
    required this.getInputEmail,
    required this.getInputPassword,
  });

  @override
  State<ButtonSubmitLogin> createState() => _ButtonSubmitLoginState();
}

class _ButtonSubmitLoginState extends State<ButtonSubmitLogin> {
  bool _validateFormEmail() {
    return validateEmailForm(widget.getInputEmail());
  }

  bool _validateFormPassword() {
    return validatePasswordForm(widget.getInputPassword());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthLoginBloc(),
      child: BlocListener<AuthLoginBloc, AuthLoginState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loading: () {
              // return showToast(message: 'Loading ...');
            },
            loaded: (data) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));
            },
            error: (message) {
              return showToast(message: message);
            },
          );
        },
        child: BlocBuilder<AuthLoginBloc, AuthLoginState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return ButtonFilled.secondary(
                  text: 'Masuk',
                  onPressed: () {
                    if (_validateFormEmail() && _validateFormPassword()) {
                      final requestModel = LoginRequestModel(
                          email: widget.getInputEmail(),
                          password: widget.getInputPassword());

                      context
                          .read<AuthLoginBloc>()
                          .add(AuthLoginEvent.login(requestModel));
                    }
                  },
                  textColor: AppColors.white,
                  fontSize: 20,
                );
              },
              loading: () {
                return ButtonFilled.primary(
                  text: '',
                  onPressed: () {},
                  loading: true,
                  textColor: AppColors.white,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
