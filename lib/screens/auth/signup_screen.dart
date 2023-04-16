import 'package:flutter/material.dart';
import 'package:foody_app/screens/auth/signin_screen.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/foody_text_input.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signUpScreen';

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
              Text(
                "Sign Up",
                style: Helper.getTheme(context).headline6,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add your details to sign up",
                ),
              ),
              const Padding(
                padding: textInputPadding,
                child: FoodyTextInput(hintText: "Name"),
              ),
              const Padding(
                padding: textInputPadding,
                child: FoodyTextInput(hintText: "Email"),
              ),
              const Padding(
                padding: textInputPadding,
                child: FoodyTextInput(hintText: "Mobile No"),
              ),
              const Padding(
                padding: textInputPadding,
                child: FoodyTextInput(hintText: "Address"),
              ),
              const Padding(
                padding: textInputPadding,
                child: FoodyTextInput(
                  hintText: "Password",
                  obscureText: true,
                ),
              ),
              const Padding(
                padding: textInputPadding,
                child: FoodyTextInput(
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
              ),
              Padding(
                padding: textInputPadding,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Sign Up"),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SigninScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Already have an Account? "),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: AppColor.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
