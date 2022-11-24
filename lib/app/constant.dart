import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mokingbird_flutter/services/models/navigator.model.dart';
import 'package:mokingbird_flutter/views/screens/pages/activites.page.dart';
import 'package:mokingbird_flutter/views/screens/pages/home_page.dart';
import 'package:mokingbird_flutter/views/screens/pages/profile.page.dart';

const appName = "MokinBird";

const Color scaffoldBackgroundColor = Color.fromARGB(255, 15, 15, 15);
const Color primaryColor = Color(0xFFFFABAE);

// shared prefrences keys
const String jwtKey = "sharedaccess_key";
const String refreshkey = "sharedRef__key";
const String usernameKey = "userdetaail_username";
const String nameKey = "userdetail_name";
const String authenticatedkey = "authenticated";

// navigator desinations
const List<NavigatorModel> navigators = [
  NavigatorModel(label: "Home", child: HomePage(), icon: Iconsax.home),
  NavigatorModel(
      label: "Activities", child: ActivitiesPage(), icon: Iconsax.heart),
  NavigatorModel(
      label: "Profile", child: ProfilePage(), icon: Iconsax.profile_2user),
];
