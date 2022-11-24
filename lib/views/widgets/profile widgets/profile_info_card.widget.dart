import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/services/models/profile.model.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            profile?.name ?? "",
            style: TextStyle(
                fontSize: 40, fontFamily: GoogleFonts.anton().fontFamily),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "@${profile?.username}",
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          profile?.contactInfo?.bio == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    (profile?.contactInfo?.bio ?? "").trimLeft(),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.ibmPlexMono().fontFamily),
                  ),
                ),
        ],
      ),
    );
  }
}
