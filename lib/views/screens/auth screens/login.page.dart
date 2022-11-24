import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/auth_api.serv.dart';
import 'package:mokingbird_flutter/views/screens/auth%20screens/register.page.dart';
import 'package:mokingbird_flutter/views/screens/main.screen.dart';
import 'package:mokingbird_flutter/views/widgets/auth%20widgets/auth_button.widget.dart';
import 'package:mokingbird_flutter/views/widgets/auth%20widgets/auth_text_field.widget.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final showError = useState(false);
    final errorDetail = useState("");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(letterSpacing: 1.6),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "MokingBird",
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: GoogleFonts.anton().fontFamily,
                    color: const Color(0xFFFFABAE)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Glad to see you again !",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              if (showError.value)
                Text(
                  errorDetail.value,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              const SizedBox(
                height: 60,
              ),
              AuthTextField(
                label: "Username",
                controller: usernameController,
                hint: "ex. xyz@gamil.com",
                secure: false,
              ),
              const SizedBox(
                height: 30,
              ),
              AuthTextField(
                controller: passwordController,
                label: "Password",
                hint: "Keep something strong!",
                secure: false,
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const RegisterPage(),
                      ));
                },
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontFamily: GoogleFonts.montserrat().fontFamily),
                        children: const [
                      TextSpan(text: "New to MokingBird ? "),
                      TextSpan(
                          text: "Register",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold))
                    ])),
              ),
              const SizedBox(
                height: 20,
              ),
              AuthButton(
                label: "Login to Continue",
                isLoading: isLoading.value,
                callback: () async {
                  isLoading.value = true;
                  if (continueLogin(
                      usernameController.text, passwordController.text)) {
                    final res = await AuthService.login(
                        usernameController.text, passwordController.text);
                    if (res) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const MainScreen(),
                          ));
                    } else {
                      showError.value = true;
                      errorDetail.value = "Something bad happend!";
                    }
                  } else {
                    showError.value = true;
                    errorDetail.value = "All Feilds are required!";
                  }
                  isLoading.value = false;
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  bool continueLogin(String username, String pass) {
    if (username.isNotEmpty && pass.isNotEmpty) {
      return true;
    }
    return false;
  }
}
