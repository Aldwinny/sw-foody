import 'package:flutter/material.dart';
import 'package:foody_app/screens/auth/forgot_password_screen.dart';
import 'package:foody_app/screens/home/intro_screen.dart';
import 'package:foody_app/widgets/foody_text_input.dart';

// Local Imports
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  static const routeName = "/signinScreen";

  static const textInputPadding =
      EdgeInsets.symmetric(vertical: 10, horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: Helper.isBackButtonRequired(context),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Row(
                      children: const [
                        BackButton(),
                        Text("Back"),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Login",
                        style: Helper.getTheme(context).headline6,
                      ),
                    ),
                    const Text('Add your details to login'),
                  ],
                ),
              ),
              const Padding(
                padding: textInputPadding,
                child: FoodyTextInput(
                  hintText: "Your email",
                ),
              ),
              const Padding(
                padding: textInputPadding,
                child: FoodyTextInput(
                  hintText: "password",
                  obscureText: true,
                ),
              ),
              Padding(
                padding: textInputPadding,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context)
                          .pushReplacementNamed(IntroScreen.routeName);
                    },
                    child: const Text("Login"),
                  ),
                ),
              ),
              Padding(
                padding: textInputPadding,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ForgotPasswordScreen.routeName);
                  },
                  child: const Text(
                    "Forget your password?",
                    style: TextStyle(
                      color: AppColor.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: textInputPadding.copyWith(top: 25),
                child: const Text("or Login With"),
              ),
              Padding(
                padding: textInputPadding,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF367FC0),
                      padding: const EdgeInsets.all(20)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Helper.getAssetName(
                          "fb.png",
                          "virtual",
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Login with Facebook")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: textInputPadding,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDD4B39),
                      padding: const EdgeInsets.all(20)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Helper.getAssetName(
                          "google.png",
                          "virtual",
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Login with Google")
                    ],
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context)
              //         .pushReplacementNamed(SignUpScreen.routeName);
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       Text("Don't have an Account?"),
              //       Text(
              //         "Sign Up",
              //         style: TextStyle(
              //           color: AppColor.red,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
