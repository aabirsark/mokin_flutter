import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

class MokinImageGen {
  static generateImage(GlobalKey globalKey) async {
    final boundray =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    final image = await boundray.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();

    if (imageBytes != null) {
      final directory = await getApplicationDocumentsDirectory();

      final imagePath = await File(
              '${directory.path}/mokinBuild${DateTime.now().microsecondsSinceEpoch}.png')
          .create();

      await imagePath.writeAsBytes(imageBytes);
      OpenFile.open(imagePath.path);
    }
  }
}
