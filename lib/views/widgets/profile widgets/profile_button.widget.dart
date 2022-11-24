import 'package:flutter/material.dart';
import 'package:mokingbird_flutter/app/constant.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.label,
    required this.icon,
    this.isDark = false,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      color: isDark ? Colors.black : primaryColor,
      child: Center(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isDark ? primaryColor : Colors.black,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: TextStyle(
                color: isDark ? primaryColor : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
