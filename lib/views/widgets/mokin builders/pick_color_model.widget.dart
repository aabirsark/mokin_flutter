import 'package:flutter/material.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/app/mokin_builder.const.dart';

class PickColorModal extends StatelessWidget {
  const PickColorModal({
    Key? key,
    required this.setColor,
  }) : super(key: key);

  final void Function(Color) setColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 1,
              width: 50,
              color: Colors.white30,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "PICK COLORS",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: mokinColors
                  .map((e) => GestureDetector(
                        onTap: () {
                          setColor(e);
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: e,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
