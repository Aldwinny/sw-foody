import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/main.dart';
import 'package:foody_app/screens/auth/forgot_password_screen.dart';
import 'package:foody_app/screens/home/intro_screen.dart';
import 'package:foody_app/widgets/foody_text_input.dart';

// Local Imports
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  static const routeName = "/signinScreen";

  static const textInputPadding =
      EdgeInsets.symmetric(vertical: 10, horizontal: 20);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<bool> _submitForm() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        User? user = userCredential.user;

        // Set user information
        // Something something

        // Cloud firestore storage
        final userRef = FirebaseFirestore.instance.collection("users");
        final query = await userRef.doc(user!.uid).get();

        if (mounted) {
          Provider.of<UserData>(context, listen: false)
              .setUser(user, query.data());
        }

        print("oh you logged in, congratz");
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          print('Wrong password');
        } else if (e.code == 'user-not-found') {
          print('User does not exists');
        } else {
          print(e);
        }
        return false;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
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
                Padding(
                  padding: SigninScreen.textInputPadding,
                  child: FoodyTextInput(
                    hintText: "Your email",
                    textEditingController: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: SigninScreen.textInputPadding,
                  child: FoodyTextInput(
                    hintText: "password",
                    textEditingController: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: SigninScreen.textInputPadding,
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (await _submitForm()) {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.of(context)
                              .pushReplacementNamed(IntroScreen.routeName);
                        }
                      },
                      child: const Text("Login"),
                    ),
                  ),
                ),
                Padding(
                  padding: SigninScreen.textInputPadding,
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
                  padding: SigninScreen.textInputPadding.copyWith(top: 25),
                  child: const Text("or Login With"),
                ),
                Padding(
                  padding: SigninScreen.textInputPadding,
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
                  padding: SigninScreen.textInputPadding,
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
                //         ReplacementNamed(SignUpScreen.routeName);
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
      ),
    );
  }
}
