import 'package:blocprovider/utilities/constants.dart';
import 'package:flutter/material.dart';

class UserEntryTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function checkValidation;
  final String labelText;
  final bool isValid;
  final bool obscureText;
  UserEntryTextField({
    Key? key,
    required this.controller,
    required this.checkValidation,
    required this.labelText,
    required this.isValid,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      onChanged: (value) {
        checkValidation(isValid);
      },
      style: const TextStyle(
          fontStyle: FontStyle.normal, fontSize: 20, color: blackColor),
      decoration: InputDecoration(
        labelText: labelText,
        errorText: isValid ? null : "InValid Data",
        errorStyle: const TextStyle(fontSize: 15),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
