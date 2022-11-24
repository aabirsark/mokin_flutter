import 'package:flutter/cupertino.dart';

class NavigatorModel {
  final String label;
  final Widget child;
  final IconData icon;

  const NavigatorModel(
      {required this.label, required this.child, required this.icon});
}
