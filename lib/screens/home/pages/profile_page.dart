import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                "Hi there Emilia!",
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
              const CustomFormImput(
                label: "Name",
                value: "Emilia Clarke",
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomFormImput(
                label: "Email",
                value: "emiliaclarke@email.com",
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomFormImput(
                label: "Mobile No",
                value: "emiliaclarke@email.com",
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomFormImput(
                label: "Address",
                value: "No 23, 6th Lane, Colombo 03",
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomFormImput(
                label: "Password",
                value: "Emilia Clarke",
                isPassword: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomFormImput(
                label: "Confirm Password",
                value: "Emilia Clarke",
                isPassword: true,
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

class CustomFormImput extends StatelessWidget {
  const CustomFormImput({
    super.key,
    required this.label,
    required this.value,
    this.isPassword = false,
  });

  final String label;
  final String value;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColor.placeholderBg,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
        ),
        obscureText: isPassword,
        initialValue: value,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
