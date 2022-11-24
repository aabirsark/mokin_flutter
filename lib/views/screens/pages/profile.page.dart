import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/auth_api.serv.dart';
import 'package:mokingbird_flutter/services/local/shared_prefs.serv.dart';
import 'package:mokingbird_flutter/services/models/profile.model.dart';
import 'package:mokingbird_flutter/views/screens/auth%20screens/login.page.dart';
import 'package:mokingbird_flutter/views/widgets/profile%20widgets/profile_function.widget.dart';
import 'package:mokingbird_flutter/views/widgets/profile%20widgets/profile_info_card.widget.dart';
import 'package:mokingbird_flutter/views/widgets/profile%20widgets/profile_thought.widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Profile? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() async {
    final res = await AuthService.profile();
    profile = res;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: Text(
            appName,
            style: TextStyle(
                fontFamily: GoogleFonts.anton().fontFamily,
                fontSize: 25,
                color: primaryColor),
          ),
          pinned: true,
          backgroundColor: scaffoldBackgroundColor,
          leadingWidth: 80,
          leading: const Center(
              child: Text(
            "Profile",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          actions: [
            GestureDetector(
              onTap: () {
                AuthService.logout();
                LocalStorage.prefs.setBool(authenticatedkey, false);
                LocalStorage.prefs.setString(jwtKey, "");
                LocalStorage.prefs.setString(refreshkey, "");
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white38),
                  ),
                ),
              ),
            )
          ],
        ),
        !isLoading
            ? profile != null
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == 0) {
                      return InfoCard(profile: profile);
                    } else if (index == 1) {
                      return ProfileFunction(profile: profile!);
                    } else if (index + 1 ==
                        (profile?.thoughts!.length ?? 0) + 3) {
                      return const SizedBox(
                        height: 100,
                      );
                    }
                    return ProfileThought(profile: profile, index: index);
                  }, childCount: (profile?.thoughts!.length ?? 0) + 3))
                : const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        "Something Bad Happend !",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
            : const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
      ],
    );
  }
}
