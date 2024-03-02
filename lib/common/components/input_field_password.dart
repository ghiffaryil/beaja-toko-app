import 'package:flutter/material.dart';

// PASSWORD TEXT INPUT
class PasswordTextInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool hidePassword;
  final String hintText;
  final TextStyle? hintStyle;
  final VoidCallback onPasswordVisibilityToggle;

  const PasswordTextInput({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.hidePassword,
    required this.hintText,
    this.hintStyle,
    required this.onPasswordVisibilityToggle,
  });

  @override
  PasswordTextInputState createState() => PasswordTextInputState();
}

class PasswordTextInputState extends State<PasswordTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      keyboardType: TextInputType.visiblePassword,
      obscureText: widget.hidePassword,
      controller: widget.controller,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        filled: true, // Set filled to true
        fillColor: Colors.white, // Set the background color
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.normal),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.all(20.0),
        suffixIcon: IconButton(
          onPressed: () {
            widget.onPasswordVisibilityToggle(); // Call the callback here
          },
          icon: Icon(
            widget.hidePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey, // Adjust the color as needed
          ),
        ),
      ),
    );
  }
}
