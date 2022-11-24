import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/services/models/thought.model.dart';

class PreviewWidget1 extends StatelessWidget {
  const PreviewWidget1({
    Key? key,
    required this.centerAlign,
    required this.model,
    required this.darkenText,
  }) : super(key: key);

  final ValueNotifier<bool> centerAlign;
  final ThoughtModel model;
  final ValueNotifier<bool> darkenText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
      child: Center(
        widthFactor: centerAlign.value ? null : 1.2,
        child: Column(
          crossAxisAlignment: centerAlign.value
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (model.quote ?? "  ").trim(),
              textAlign: centerAlign.value ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: darkenText.value ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.ibmPlexMono().fontFamily),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("~ ${model.user?.name ?? ""}",
                style: TextStyle(
                    // fontSize: 16,
                    color: darkenText.value ? Colors.black : Colors.white,
                    // fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                    fontFamily: GoogleFonts.ibmPlexMono().fontFamily))
          ],
        ),
      ),
    );
  }
}
