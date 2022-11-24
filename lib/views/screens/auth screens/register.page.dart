import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/auth_api.serv.dart';
import 'package:mokingbird_flutter/views/screens/auth%20screens/login.page.dart';
import 'package:mokingbird_flutter/views/screens/main.screen.dart';
import 'package:mokingbird_flutter/views/widgets/auth%20widgets/auth_button.widget.dart';
import 'package:mokingbird_flutter/views/widgets/auth%20widgets/auth_text_field.widget.dart';

class RegisterPage extends HookWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final usernameController = useTextEditingController();
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final showError = useState(false);
    final errorDetail = useState("");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Register",
          style: TextStyle(letterSpacing: 1.6),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
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
                "We are Glad to connect !",
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
                height: 70,
              ),
              AuthTextField(
                label: "Name",
                controller: nameController,
                hint: "ex. Jhon Dalton",
                secure: false,
              ),
              const SizedBox(
                height: 30,
              ),
              AuthTextField(
                controller: usernameController,
                label: "Username",
                hint: "Keep something unique!",
                secure: false,
              ),
              const SizedBox(
                height: 30,
              ),
              AuthTextField(
                label: "Password",
                controller: passwordController,
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
                        builder: (context) => const LoginPage(),
                      ));
                },
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontFamily: GoogleFonts.montserrat().fontFamily),
                        children: const [
                      TextSpan(text: "Already joined MokingBird ? "),
                      TextSpan(
                          text: "Login",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold))
                    ])),
              ),
              const SizedBox(
                height: 20,
              ),
              AuthButton(
                isLoading: isLoading.value,
                label: "Register to Continue",
                callback: () async {
                  isLoading.value = true;
                  if (usernameController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    final res = await AuthService.register(
                        usernameController.text,
                        passwordController.text,
                        nameController.text);
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
}
