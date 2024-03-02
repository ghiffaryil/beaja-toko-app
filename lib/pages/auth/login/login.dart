import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/components/input_field_password.dart';
import 'package:beaja_toko/common/components/input_field_text.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/images.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/pages/auth/login/widgets/button/button_submit_login.dart';
import 'package:beaja_toko/pages/auth/register/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();

  final FocusNode inputEmailFocus = FocusNode();
  final FocusNode inputPasswordFocus = FocusNode();

  bool _hideinputPassword = true;

  final double defaultMargin = 0.18;
  double topMargin = 0.18;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    inputEmailFocus.addListener(_handleFocusChange);
    inputPasswordFocus.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (inputEmailFocus.hasFocus || inputPasswordFocus.hasFocus) {
      setState(() {
        topMargin = 0.0;
      });
    } else {
      setState(() {
        topMargin = defaultMargin;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    inputEmailFocus.dispose();
    inputPasswordFocus.dispose();
    super.dispose();
  }

  void _showHideinputPasswordTogle() {
    setState(() {
      _hideinputPassword = !_hideinputPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            Images.onboardingBackground, // replace with your image path
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          // Content container
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * topMargin,
            ),
            padding: const EdgeInsets.all(35.0),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username text field
                  Center(
                    child: Image.asset(
                      Images.logoWhite,
                      width: 200,
                    ),
                  ),
                  CustomDividers.regularDivider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyles.h2(color: AppColors.white),
                      ),
                      Text(
                        'Enter your email and password',
                        style: TextStyles.large(color: AppColors.white),
                      ),
                    ],
                  ),
                  CustomDividers.smallDivider(),
                  TextInputField(
                    focusNode: inputEmailFocus,
                    keyboardType: TextInputType.emailAddress,
                    controller: inputEmail,
                    hintText: 'Masukkan Email Kamu',
                  ),
                  CustomDividers.verySmallDivider(),
                  // Password text field
                  PasswordTextInput(
                    focusNode: inputPasswordFocus,
                    controller: inputPassword,
                    hintText: 'Masukkan Password',
                    hidePassword: _hideinputPassword,
                    onPasswordVisibilityToggle: _showHideinputPasswordTogle,
                  ),
                  CustomDividers.smallDivider(),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Lupa Password',
                      style: TextStyles.regular(color: AppColors.bg),
                    ),
                  ),
                  CustomDividers.regularDivider(),
                  // Login button
                  ButtonSubmitLogin(
                    getInputEmail: () => inputEmail.text,
                    getInputPassword: () => inputPassword.text,
                  ),
                  // SIGN UP
                  CustomDividers.regularDivider(),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Belum Punya Akun?',
                          style: TextStyles.large(color: AppColors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const RegisterPage();
                            }));
                          },
                          child: Text(
                            'Daftar di sini',
                            style: TextStyles.h3(color: AppColors.bg),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
