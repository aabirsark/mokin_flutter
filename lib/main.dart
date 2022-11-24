import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/bloc/navigator%20state%20bloc/navigator_bloc.dart';
import 'package:mokingbird_flutter/services/bloc/posts%20state%20bloc/posts_bloc_bloc.dart';

import 'package:mokingbird_flutter/services/local/shared_prefs.serv.dart';
import 'package:mokingbird_flutter/views/screens/auth%20screens/register.page.dart';
import 'package:mokingbird_flutter/views/screens/main.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  LocalStorage.setPrefs(prefs);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => NavigatorBloc(),
    ),
    BlocProvider(
      create: (context) => PostsBlocBloc()..add(PostBlocLoad()),
    )
  ], child: const MokinBird()));

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: scaffoldBackgroundColor,
      systemNavigationBarColor: scaffoldBackgroundColor));
}

class MokinBird extends StatelessWidget {
  const MokinBird({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
              elevation: 0.0,
              color: Colors.transparent,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.montserrat().fontFamily)),
          fontFamily: GoogleFonts.montserrat().fontFamily),
      home: (LocalStorage.prefs.getBool(authenticatedkey) ?? false)
          ? const MainScreen()
          : const RegisterPage(),
    );
  }
}
