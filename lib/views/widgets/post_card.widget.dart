import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/thought_api.serv.dart';
import 'package:mokingbird_flutter/services/models/thought.model.dart';
import 'package:mokingbird_flutter/views/screens/comment.page.dart';
import 'package:mokingbird_flutter/views/screens/mokin%20builder/mokin_build1.screen.dart';
import 'package:mokingbird_flutter/views/screens/user_profile.screen.dart';

class PostCard extends HookWidget {
  const PostCard({
    Key? key,
    this.showFooter = true,
    required this.model,
  }) : super(key: key);

  final ThoughtModel model;
  final bool showFooter;

  @override
  Widget build(BuildContext context) {
    final isLiked = useState(false);

    return Container(
      width: double.infinity,
      color: Colors.white10,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => UserProfile(userId: model.user!.id!),
                  ));
            },
            child: Row(
              children: [
                Text(
                  model.user?.name ?? "UNKNOWN",
                  style: TextStyle(
                      fontSize: 18, fontFamily: GoogleFonts.anton().fontFamily),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  getDate(model.createdAt ?? 0),
                  style: const TextStyle(fontSize: 12, color: Colors.white54),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "@${model.user?.username ?? ""}",
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.quote?.trim() ?? "",
            style: TextStyle(
                height: 1.5,
                fontSize: 18,
                fontFamily: GoogleFonts.ibmPlexMono().fontFamily),
          ),
          SizedBox(
            height: showFooter ? 30 : 10,
          ),
          if (showFooter)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CommentPage(model: model),
                        ));
                  },
                  child: Container(
                    color: scaffoldBackgroundColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: const Text("comment"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    await ThoughtAPIService.likePost(
                        model.user!.id!, model.id!);
                    isLiked.value = true;
                  },
                  child: Container(
                    color: isLiked.value ? Colors.transparent : primaryColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      isLiked.value ? "Liked" : "Like",
                      style: TextStyle(
                          color: isLiked.value ? Colors.grey : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => MokinBuild1(model: model),
                        ));
                  },
                  child: const Text(
                    "Mokin",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

getDate(int milliSeconds) {
  final date = DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  final dateString = "${date.day} / ${date.month} / ${date.year}";
  return dateString;
}
