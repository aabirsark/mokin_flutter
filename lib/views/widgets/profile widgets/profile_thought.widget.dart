import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/local/shared_prefs.serv.dart';
import 'package:mokingbird_flutter/services/models/profile.model.dart';
import 'package:mokingbird_flutter/services/models/thought.model.dart';
import 'package:mokingbird_flutter/views/screens/comment.page.dart';
import 'package:mokingbird_flutter/views/screens/mokin%20builder/mokin_build1.screen.dart';

class ProfileThought extends StatelessWidget {
  const ProfileThought({
    Key? key,
    required this.profile,
    required this.index,
  }) : super(key: key);

  final Profile? profile;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      color: Colors.white10,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile?.name ?? "",
            style: TextStyle(
                fontSize: 20, fontFamily: GoogleFonts.anton().fontFamily),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "@${profile?.username ?? ""}",
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            (profile?.thoughts![index - 2].quote ?? "").trim(),
            style: TextStyle(
                height: 1.5,
                fontSize: 18,
                fontFamily: GoogleFonts.ibmPlexMono().fontFamily),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              final model = ThoughtModel(
                  quote: profile?.thoughts![index - 2].quote,
                  user: ThoughtUserModel(name: profile?.name));
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MokinBuild1(model: model),
                  ));
            },
            child: const Text(
              "Mokin",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
