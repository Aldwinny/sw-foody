import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/main.dart';
import 'package:foody_app/screens/auth/signin_screen.dart';
import 'package:foody_app/screens/auth/signup_screen.dart';
import 'package:foody_app/screens/home/home_screen.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = "/landingScreen";

  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initUserInformation();
    });
    super.initState();
  }

  _initUserInformation() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userRef = FirebaseFirestore.instance.collection("users");
      final query = await userRef.doc(user.uid).get();

      if (mounted) {
        Provider.of<UserData>(context, listen: false)
            .setUser(user, query.data());
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    color: AppColor.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                  ),
                  child: Image.asset(
                    Helper.getAssetName("login_bg.png", "virtual"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  flex: 6,
                  child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const Flexible(
                              child: Text(
                                "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(SigninScreen.routeName);
                                  },
                                  child: const Text("Login"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all(AppColor.red),
                                    shape: MaterialStateProperty.all(
                                      const StadiumBorder(
                                        side: BorderSide(
                                            color: AppColor.red, width: 1.5),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(SignUpScreen.routeName);
                                  },
                                  child: const Text("Create an Account"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )))
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Image.asset(Helper.getAssetName("foody_logo.png", "logo"),
                  scale: 2.5),
            ),
          ),
        ],
      ),
    );
  }
}
