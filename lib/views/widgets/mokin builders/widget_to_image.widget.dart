import 'package:flutter/material.dart';

class WidgetToImage extends StatelessWidget {
  const WidgetToImage({super.key, required this.builder});

  final Function(GlobalKey) builder;

  @override
  Widget build(BuildContext context) {
    final GlobalKey globalKey = GlobalKey();

    return RepaintBoundary(
      key: globalKey,
      child: builder(globalKey),
    );
  }
}
