import 'package:beaja_toko/bloc/auth/login/auth_login_bloc.dart';
import 'package:beaja_toko/bloc/auth/logout/logout_bloc.dart';
import 'package:beaja_toko/bloc/auth/register/auth_register_bloc.dart';
import 'package:beaja_toko/bloc/auth/verify_otp/verify_otp_bloc.dart';
import 'package:beaja_toko/bloc/product/create_item/create_item_bloc.dart';
import 'package:beaja_toko/bloc/product/get_item/get_item_bloc.dart';
import 'package:beaja_toko/bloc/profile/create_user_details/create_user_details_bloc.dart';
import 'package:beaja_toko/bloc/profile/get_user_details/get_user_details_bloc.dart';
import 'package:beaja_toko/bloc/profile/update_image_user_details/update_image_user_details_bloc.dart';
import 'package:beaja_toko/bloc/profile/update_user_details/update_user_details_bloc.dart';
import 'package:beaja_toko/config/config.dart';
import 'package:beaja_toko/config/flavor_type.dart';
import 'package:beaja_toko/pages/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

MyApp initializeApp(AppConfig config) {
  WidgetsFlutterBinding.ensureInitialized();

  return MyApp(config: config);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.config});
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthRegisterBloc(),
        ),
        BlocProvider(
          create: (context) => AuthLoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => VerifyOtpBloc(),
        ),
        BlocProvider(
          create: (context) => GetUserDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => CreateUserDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateUserDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateImageUserDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => GetItemBloc(),
        ),
        BlocProvider(
          create: (context) => CreateItemBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:
            FlavorType.dev == config.flavor ? true : false,
        title: config.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        home: BlocProvider(
          create: (context) => AuthLoginBloc(),
          child: const SplashScreenPage(),
        ),
      ),
    );
  }
}
