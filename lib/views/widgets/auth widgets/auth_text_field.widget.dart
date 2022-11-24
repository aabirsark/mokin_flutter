import 'package:flutter/material.dart';
import 'package:mokingbird_flutter/app/constant.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.label,
    this.controller,
    required this.secure,
    required this.hint,
  }) : super(key: key);

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      controller: controller,
      obscureText: secure,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 26.0, vertical: 20.0),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white10),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(0)),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14),
          label: Text(label),
          labelStyle: const TextStyle(fontSize: 16, color: Colors.white),
          filled: true,
          fillColor: Colors.white10),
    );
  }
}
