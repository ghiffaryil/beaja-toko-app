// ignore_for_file: unused_field
import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/images.dart';
import 'package:beaja_toko/pages/auth/login/login.dart';
import 'package:flutter/material.dart';

// Import Component
import 'package:upgrader/upgrader.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
  }

  final upgrader = Upgrader(
    minAppVersion: Variables.appVersion,
    durationUntilAlertAgain: const Duration(minutes: 1),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.onboardingBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Image.asset(
                    Images.logoWhite,
                    width: 150,
                  ),
                ),
              ),
              CustomDividers.extraLargeDivider(),
              Padding(
                padding: const EdgeInsets.all(45),
                child: Center(
                  child: ButtonFilled.primary(
                      text: 'Get Started',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return const LoginPage();
                        })));
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
