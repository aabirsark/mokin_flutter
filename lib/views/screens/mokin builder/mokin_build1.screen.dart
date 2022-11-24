import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/app/mokin_builder.const.dart';
import 'package:mokingbird_flutter/services/models/thought.model.dart';
import 'package:mokingbird_flutter/services/mokin/mokin_img_gen.serv.dart';
import 'package:mokingbird_flutter/views/widgets/mokin%20builders/pick_color_model.widget.dart';
import 'package:mokingbird_flutter/views/widgets/mokin%20builders/preview1.widget.dart';
import 'package:mokingbird_flutter/views/widgets/mokin%20builders/widget_to_image.widget.dart';

class MokinBuild1 extends HookWidget {
  const MokinBuild1({super.key, required this.model});

  final ThoughtModel model;

  @override
  Widget build(BuildContext context) {
    late GlobalKey key;
    final bgColor = useState(mokinColors[0]);
    final darkenText = useState(true);
    final centerAlign = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MokinBuild",
          style: TextStyle(
              fontSize: 23,
              fontFamily: GoogleFonts.anton().fontFamily,
              color: primaryColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              MokinImageGen.generateImage(key);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                  child: Text(
                "Export",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    builder: (context) => PickColorModal(
                      setColor: (color) {
                        bgColor.value = color;
                      },
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    "Pick Color",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  centerAlign.value = !centerAlign.value;
                },
                child: const Center(
                  child: Text(
                    "Text Align",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  darkenText.value = !darkenText.value;
                },
                child: const Center(
                  child: Text(
                    "Text Color",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(child: WidgetToImage(builder: (ky) {
        key = ky;
        return Container(
          margin: const EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.width - 8.0,
          width: MediaQuery.of(context).size.width - 8,
          decoration: BoxDecoration(
            color: bgColor.value,
          ),
          child: Stack(
            children: [
              PreviewWidget1(
                  centerAlign: centerAlign,
                  model: model,
                  darkenText: darkenText),
              Positioned(
                bottom: 10,
                right: 10,
                child: Text(
                  "MokinBird",
                  style: TextStyle(
                      color: darkenText.value ? Colors.black12 : Colors.white12,
                      fontSize: 12,
                      fontFamily: GoogleFonts.anton().fontFamily),
                ),
              )
            ],
          ),
        );
      })),
    );
  }
}
