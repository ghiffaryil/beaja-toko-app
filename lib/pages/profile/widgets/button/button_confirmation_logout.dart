import 'package:beaja_toko/bloc/auth/logout/logout_bloc.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/pages/auth/login/login.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonConfirmationLogout extends StatelessWidget {
  const ButtonConfirmationLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocProvider(
            create: (context) => LogoutBloc(),
            child: BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                state.maybeWhen(
                    orElse: () {},
                    loaded: (data) {
                      AuthLocalRepository().removeAuthData();
                      AuthLocalRepository().clearAuthData();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                      // Future.delayed(const Duration(milliseconds: 500), () {

                      // });
                    },
                    error: (message) {
                      AuthLocalRepository().removeAuthData();
                      AuthLocalRepository().clearAuthData();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      });
                    });
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return ButtonOutlined.primary(
                      text: 'Ya, Keluar',
                      onPressed: () {
                        context
                            .read<LogoutBloc>()
                            .add(const LogoutEvent.logout());
                      },
                    );
                  },
                  loading: () {
                    return ButtonOutlined.primary(
                      text: '',
                      onPressed: () {},
                      loading: true,
                    );
                  },
                );
              },
            )),
        const SizedBox(
          height: 15,
        ),
        ButtonFilled.primary(
            text: 'Tidak, Batal',
            textColor: AppColors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
