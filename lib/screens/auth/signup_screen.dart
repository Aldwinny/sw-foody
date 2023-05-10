import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/main.dart';
import 'package:foody_app/screens/auth/signin_screen.dart';
import 'package:foody_app/screens/home/intro_screen.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/foody_text_input.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signUpScreen';

  static const textInputPadding =
      EdgeInsets.symmetric(vertical: 10, horizontal: 20);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileNoController = TextEditingController();
  final _addressController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _passwordController = TextEditingController();

  String error = '';
  bool isLoading = false;

  Future<bool> _submitForm() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final address = _addressController.text.trim();
    final number = _mobileNoController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        User? user = userCredential.user;

        // Set user information
        await user!.updateDisplayName(name);

        // Cloud firestore storage

        final userRef = FirebaseFirestore.instance.collection("users");
        await userRef.doc(user.uid).set({
          'name': name,
          'address': address,
          'number': number,
        });

        final query = await userRef.doc(user.uid).get();
        if (mounted) {
          Provider.of<UserData>(context, listen: false)
              .setUser(user, query.data());
        }

        setState(() => error = "");
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() => error = "The password provided is too weak");
        } else if (e.code == 'email-already-in-use') {
          setState(() => error = "An account already exists with that email");
        } else {
          setState(() => error = "An error has occurred");
        }
        return false;
      } catch (e) {
        setState(() => error =
            "An unknown error has occurred. Please check your connection.");
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: Helper.getTheme(context).headline6,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add your details to sign up",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: SignUpScreen.textInputPadding,
                  child: FoodyTextInput(
                      hintText: "Name",
                      textEditingController: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: SignUpScreen.textInputPadding,
                  child: FoodyTextInput(
                    hintText: "Email",
                    textEditingController: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: SignUpScreen.textInputPadding,
                  child: FoodyTextInput(
                      hintText: "Mobile No",
                      textEditingController: _mobileNoController,
                      validator: (value) {
                        final numericRegex = RegExp(r'^\d+$');
                        if (value!.isEmpty) {
                          return "Please enter your mobile no";
                        } else if (!numericRegex.hasMatch(value)) {
                          return "Your mobile number is invalid";
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: SignUpScreen.textInputPadding,
                  child: FoodyTextInput(
                    hintText: "Address",
                    textEditingController: _addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "PLease enter your current address";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: SignUpScreen.textInputPadding,
                  child: FoodyTextInput(
                    hintText: "Password",
                    obscureText: true,
                    textEditingController: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: SignUpScreen.textInputPadding,
                  child: FoodyTextInput(
                    textEditingController: _confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please reenter the password";
                      } else if (value != _passwordController.text) {
                        return "Passwords must be the same";
                      }
                      return null;
                    },
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
                ),
                !isLoading && error != ''
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(error,
                            style: const TextStyle(
                              color: AppColor.red,
                            )),
                      )
                    : isLoading
                        ? CircularProgressIndicator()
                        : Text(''),
                Padding(
                  padding: SignUpScreen.textInputPadding,
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        print('hi');
                        setState(() {
                          isLoading = true;
                        });
                        if (await _submitForm()) {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.of(context)
                              .pushReplacementNamed(IntroScreen.routeName);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
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
            ),
          )),
        ));
  }
}
