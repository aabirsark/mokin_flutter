import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mokingbird_flutter/services/models/profile.model.dart';
import 'package:mokingbird_flutter/views/screens/edit.page.dart';
import 'package:mokingbird_flutter/views/screens/new_thought.page.dart';
import 'package:mokingbird_flutter/views/widgets/profile%20widgets/profile_button.widget.dart';

class ProfileFunction extends StatelessWidget {
  const ProfileFunction({
    Key? key, required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => EditPage(profile: profile,),
                  ));
            },
            child: const ProfileButton(
              icon: Iconsax.pen_add,
              label: "EDIT",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const MokinWrite(),
                  ));
            },
            child: const ProfileButton(
              icon: Iconsax.add,
              label: "NEW POST",
              isDark: true,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
