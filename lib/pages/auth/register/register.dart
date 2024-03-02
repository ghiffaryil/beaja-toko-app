import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/components/input_field_password.dart';
import 'package:beaja_toko/common/components/input_field_text.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/images.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/pages/auth/login/login.dart';
import 'package:beaja_toko/pages/auth/register/widgets/button/button_submit_register.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with WidgetsBindingObserver {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputPasswordConfirmation = TextEditingController();

  FocusNode inputEmailFocus = FocusNode();
  FocusNode inputPasswordFocus = FocusNode();
  FocusNode inputPasswordConfirmationFocus = FocusNode();

  bool _hideinputPassword = true;
  bool _hideinputPasswordConfirmation = true;

  void _showHideinputPasswordTogle() {
    setState(() {
      _hideinputPassword = !_hideinputPassword;
    });
  }

  void _showHideinputPasswordConfirmationTogle() {
    setState(() {
      _hideinputPasswordConfirmation = !_hideinputPasswordConfirmation;
    });
  }

  final double defaultMargin = 0.18;
  double topMargin = 0.18;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Listen to changes in focus state
    inputEmailFocus.addListener(_handleFocusChange);
    inputPasswordFocus.addListener(_handleFocusChange);
    inputPasswordConfirmationFocus.addListener(_handleFocusChange);
  }

  // Adjust the margin based on focus change
  void _handleFocusChange() {
    if (inputEmailFocus.hasFocus ||
        inputPasswordFocus.hasFocus ||
        inputPasswordConfirmationFocus.hasFocus) {
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
    inputPasswordConfirmationFocus.dispose();
    super.dispose();
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
                  // email text field
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginPage();
                                }));
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.white,
                              )),
                          Text(
                            'Register',
                            style: TextStyles.h2(color: AppColors.white),
                          ),
                        ],
                      ),
                      Text(
                        'Daftarkan akun anda sekarang',
                        style: TextStyles.large(color: AppColors.white),
                      ),
                    ],
                  ),
                  CustomDividers.regularDivider(),
                  TextInputField(
                    focusNode: inputEmailFocus,
                    keyboardType: TextInputType.emailAddress,
                    controller: inputEmail,
                    hintText: 'Email',
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                  CustomDividers.smallDivider(),
                  PasswordTextInput(
                    focusNode: inputPasswordFocus,
                    controller: inputPassword,
                    hintText: 'Password',
                    hidePassword: _hideinputPassword,
                    onPasswordVisibilityToggle: _showHideinputPasswordTogle,
                  ),
                  CustomDividers.smallDivider(),
                  PasswordTextInput(
                    focusNode: inputPasswordConfirmationFocus,
                    controller: inputPasswordConfirmation,
                    hintText: 'Konfirmasi Password',
                    hidePassword: _hideinputPasswordConfirmation,
                    onPasswordVisibilityToggle:
                        _showHideinputPasswordConfirmationTogle,
                  ),
                  CustomDividers.regularDivider(),
                  ButtonSubmitRegister(
                    getInputEmail: () => inputEmail.text,
                    getInputPassword: () => inputPassword.text,
                    getInputPasswordConfirmation: () =>
                        inputPasswordConfirmation.text,
                  ),
                  CustomDividers.smallDivider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
