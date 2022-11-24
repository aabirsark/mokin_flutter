import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/thought_api.serv.dart';

class MokinWrite extends HookWidget {
  const MokinWrite({super.key});

  @override
  Widget build(BuildContext context) {
    final thoughtField = useTextEditingController();
    final showFAB = useState(false);
    final isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MokinWrite",
          style: TextStyle(
              fontFamily: GoogleFonts.anton().fontFamily,
              fontSize: 25,
              color: primaryColor),
        ),
      ),
      floatingActionButton: showFAB.value
          ? FloatingActionButton(
              onPressed: () async {
                if (!isLoading.value) {
                  isLoading.value = true;
                  if (thoughtField.text.isNotEmpty) {
                    final res = await ThoughtAPIService.createNewThought(
                        thoughtField.text);
                    if (res) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  }
                  isLoading.value = false;
                }
              },
              backgroundColor: primaryColor,
              child: !isLoading.value
                  ? const Icon(Icons.done)
                  : const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 3,
                      ),
                    ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: thoughtField,
            onChanged: (value) => {
              if (value.isNotEmpty && !showFAB.value)
                showFAB.value = true
              else if (value.isEmpty && showFAB.value)
                showFAB.value = false
            },
            cursorColor: primaryColor,
            maxLines: null,
            maxLength: 200,
            cursorWidth: 10,
            buildCounter: (context,
                {int? currentLength, bool? isFocused, maxLength}) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: (currentLength ?? 0) <= 0 ? 0 : 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor)),
                      child: Text(
                        "$currentLength / $maxLength",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              );
            },
            style: TextStyle(
                fontSize: 24,
                fontFamily: GoogleFonts.ibmPlexMono().fontFamily,
                fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "Your Thought..."),
          )
        ]),
      ),
    );
  }
}
