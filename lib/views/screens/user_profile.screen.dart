import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/auth_api.serv.dart';
import 'package:mokingbird_flutter/services/models/profile.model.dart';
import 'package:mokingbird_flutter/views/widgets/profile%20widgets/profile_button.widget.dart';
import 'package:mokingbird_flutter/views/widgets/profile%20widgets/profile_function.widget.dart';
import 'package:mokingbird_flutter/views/widgets/profile%20widgets/profile_info_card.widget.dart';
import 'package:mokingbird_flutter/views/widgets/profile%20widgets/profile_thought.widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.userId});

  final int userId;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Profile? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() async {
    final res = await AuthService.getAnotherProfile(widget.userId);
    profile = res;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(
              "MokinProfile",
              style: TextStyle(
                  fontFamily: GoogleFonts.anton().fontFamily,
                  fontSize: 25,
                  color: primaryColor),
            ),
            pinned: true,
            backgroundColor: scaffoldBackgroundColor,
          ),
          !isLoading
              ? profile != null
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                      if (index == 0) {
                        return InfoCard(profile: profile);
                      } else if (index == 1) {
                        return const UserProfileFunctions();
                      }
                      return ProfileThought(
                        profile: profile,
                        index: index,
                      );
                    }, childCount: (profile?.thoughts!.length ?? 0) + 2))
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
      ),
    );
  }
}

class UserProfileFunctions extends StatelessWidget {
  const UserProfileFunctions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ProfileButton(
            label: "FOLLOW",
            icon: Iconsax.add,
          ),
          SizedBox(
            height: 15,
          ),
          ProfileButton(
            label: "CONTACT",
            icon: Iconsax.call,
            isDark: true,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
