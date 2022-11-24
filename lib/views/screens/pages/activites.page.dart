import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/thought_api.serv.dart';
import 'package:mokingbird_flutter/services/models/activity.model.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  List<Activity>? activites;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    final res = await ThoughtAPIService.getActivites();

    setState(() {
      activites = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String like = "like";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
          style: TextStyle(
              fontFamily: GoogleFonts.anton().fontFamily,
              fontSize: 25,
              color: primaryColor),
        ),
        leadingWidth: 80,
        leading: const Center(
            child: Text(
          "Activity",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                "Edit",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white38),
              ),
            ),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : ListView.builder(
              itemCount: activites?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    activites?.elementAt(index).type == "like"
                        ? Iconsax.heart
                        : CupertinoIcons.chat_bubble,
                    color: primaryColor,
                  ),
                  title: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                          children: [
                        TextSpan(
                            text: (activites?.elementAt(index).user?.username ??
                                    0)
                                .toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "  ${activites?.elementAt(index).type}ed on your thought")
                      ])),
                );
              },
            ),
    );
  }
}
