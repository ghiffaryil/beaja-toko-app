import 'dart:async';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/images.dart';
import 'package:beaja_toko/common/functions/check_token/check_token.dart';
import 'package:beaja_toko/pages/homepage/homepage.dart';
import 'package:beaja_toko/pages/onboarding/onboarding.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:beaja_toko/repository/maps/cart_check_maps.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  bool isLogged = false;
  bool isExpiredToken = false;
  String userToken = '';
  int userId = 0;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() {
    TokenChecker.checkToken(
      setStateCallback: (bool getIsLogged, String getUserToken,
          String getUserEmail, bool getIsExpiredToken, int getUserId) {
        setState(() {
          isLogged = getIsLogged;
          isExpiredToken = getIsExpiredToken;
          userToken = getUserToken;
          userId = getUserId;
        });
        // print(userToken);
        CheckMapsRepository().removeCheckMaps();
        openSplashScreen();
      },
    );
  }

  openSplashScreen() async {
    var splashDuration = const Duration(seconds: 2);
    return Timer(splashDuration, () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => FutureBuilder<bool>(
                future: AuthLocalRepository().isHaveToken(),
                builder: (context, snapshot) {
                  if (isExpiredToken) {
                    return const OnboardingPage();
                  } else if (snapshot.hasData && snapshot.data!) {
                    return const HomePage();
                  } else {
                    return const OnboardingPage();
                  }
                },
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(50),
        color: AppColors.white,
        child: Center(
          child: Image.asset(
            Images.logoPrimary,
            width: 200,
          ),
        ),
      ),
    );
  }
}
