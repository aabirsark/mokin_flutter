import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/auth_api.serv.dart';
import 'package:mokingbird_flutter/services/models/profile.model.dart';

class EditPage extends HookWidget {
  const EditPage({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController =
        useTextEditingController(text: profile.contactInfo?.email);
    final bioController =
        useTextEditingController(text: profile.contactInfo?.bio);
    final addressController =
        useTextEditingController(text: profile.contactInfo?.address);

    final isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontFamily: GoogleFonts.anton().fontFamily,
              fontSize: 25,
              color: primaryColor),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          print('heee');
          isLoading.value = true;
          if (true) {
            if (nameController.text.isNotEmpty ||
                emailController.text.isNotEmpty ||
                bioController.text.isNotEmpty ||
                addressController.text.isNotEmpty) {
              print("got here");
              final res = await AuthService.addUserInfo(
                  email: emailController.text,
                  bio: bioController.text,
                  address: addressController.text);
              print(res);
              if (res) {
                // ignore: use_build_context_synchronously
                return Navigator.pop(context);
              }
            }
          }
          isLoading.value = false;
        },
        child: Container(
          height: 50,
          width: double.infinity,
          color: primaryColor,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
          child: Center(
            child: !isLoading.value
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Iconsax.save_2,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "SAVE",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(
                    color: Colors.black,
                  ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              EditTextField(
                controller: nameController,
                label: "Name",
                maxLength: 50,
              ),
              const SizedBox(
                height: 15,
              ),
              EditTextField(
                controller: bioController,
                label: "Bio",
                maxLength: 70,
              ),
              const SizedBox(
                height: 15,
              ),
              EditTextField(
                controller: emailController,
                label: "Email",
                maxLength: 35,
              ),
              const SizedBox(
                height: 15,
              ),
              EditTextField(
                controller: addressController,
                label: "Address",
                maxLength: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditTextField extends StatelessWidget {
  const EditTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.maxLength,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      controller: controller,
      maxLines: null,
      maxLength: maxLength,
      style: TextStyle(
        fontSize: 18,
        fontFamily: GoogleFonts.ibmPlexMono().fontFamily,
      ),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          border: InputBorder.none,
          hintText: label,
          filled: true),
    );
  }
}
