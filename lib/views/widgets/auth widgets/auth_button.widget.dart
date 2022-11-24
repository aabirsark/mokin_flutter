import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mokingbird_flutter/app/constant.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.label,
    required this.callback,
    required this.isLoading,
  }) : super(key: key);

  final String label;
  final bool isLoading;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 50,
        decoration: const BoxDecoration(color: primaryColor),
        width: double.infinity,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.black,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      CupertinoIcons.arrow_right,
                      size: 18,
                      color: Colors.black,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
