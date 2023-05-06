import 'package:flutter/material.dart';
import 'package:foody_app/main.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';
import 'package:foody_app/widgets/foody_text_input.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context).user;
    final userData = Provider.of<UserData>(context).userData;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 120),
          child: Column(
            children: [
              const FoodyAppBar(
                label: 'Profile',
                useBackButton: false,
                useCart: true,
              ),
              const SizedBox(
                height: 20,
              ),
              ClipOval(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset(
                        Helper.getAssetName(
                          "user.jpg",
                          "real",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 20,
                        width: 80,
                        color: Colors.black.withOpacity(0.3),
                        child: Image.asset(
                            Helper.getAssetName("camera.png", "virtual")),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Helper.getAssetName("edit_filled.png", "virtual"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Edit Profile",
                    style: TextStyle(color: AppColor.red),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Hi there ${user?.displayName ?? 'User'}",
                style: Helper.getTheme(context).headline4!.copyWith(
                      color: AppColor.primary,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Sign Out"),
              const SizedBox(
                height: 40,
              ),
              FoodyTextInput(
                label: "Name",
                value: user?.displayName,
              ),
              const SizedBox(
                height: 20,
              ),
              FoodyTextInput(
                label: "Mobile No",
                value: userData?['number'],
              ),
              const SizedBox(
                height: 20,
              ),
              FoodyTextInput(
                label: "Address",
                value: userData?['address'],
              ),
              const SizedBox(
                height: 20,
              ),
              const FoodyTextInput(
                label: "Enter your password before saving changes",
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Save"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
