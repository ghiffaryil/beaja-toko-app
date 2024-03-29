import 'package:beaja_toko/bloc/auth/register/auth_register_bloc.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/functions/validate/validate_form_email.dart';
import 'package:beaja_toko/common/functions/validate/validate_form_password.dart';
import 'package:beaja_toko/models/auth/register/register_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonSubmitRegister extends StatefulWidget {
  final String Function() getInputEmail;
  final String Function() getInputPassword;
  final String Function() getInputPasswordConfirmation;

  const ButtonSubmitRegister({
    super.key,
    required this.getInputEmail,
    required this.getInputPassword,
    required this.getInputPasswordConfirmation,
  });

  @override
  State<ButtonSubmitRegister> createState() => _ButtonSubmitRegisterState();
}

class _ButtonSubmitRegisterState extends State<ButtonSubmitRegister> {
  bool _validateFormEmail() {
    return validateEmailForm(widget.getInputEmail());
  }

  bool _validateFormPassword() {
    return validatePasswordForm(widget.getInputPassword());
  }

  bool _validateFormPasswordConfirmation() {
    return validatePasswordForm(widget.getInputPasswordConfirmation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthRegisterBloc, AuthRegisterState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return ButtonFilled.secondary(
              text: 'Daftar',
              onPressed: () {
                if (_validateFormEmail() &&
                    _validateFormPassword() &&
                    _validateFormPasswordConfirmation()) {
                  final requestModel = RegisterRequestModel(
                    email: widget.getInputEmail(),
                    password: widget.getInputPassword(),
                    isAdmin: false,
                  );
                  context
                      .read<AuthRegisterBloc>()
                      .add(AuthRegisterEvent.register(requestModel));
                }
              },
              fontSize: 20,
            );
          },
          loading: () {
            return ButtonFilled.primary(
              text: '',
              onPressed: () {},
              loading: true,
            );
          },
        );
      },
    );
  }
}
