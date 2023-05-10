import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/main.dart';
import 'package:foody_app/screens/landing_screen.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';
import 'package:foody_app/widgets/foody_text_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String error = '';
  bool isLoading = false;
  User? globalUser;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      globalUser = FirebaseAuth.instance.currentUser;
      var userData = Provider.of<UserData>(context, listen: false).userData;

      if (userData == null) {
        final userRef = FirebaseFirestore.instance.collection('users');
        final query = await userRef.doc(globalUser!.uid).get();
      }

      _nameController.text = globalUser?.displayName ?? '';
      _numberController.text = userData?['number'] ?? '';
      _addressController.text = userData?['address'] ?? '';
    });
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    // Create a unique filename for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Reference to the Firebase storage bucket where the image will be uploaded
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');

    // Upload the image to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot storageSnapshot = await uploadTask;

    // Get the download URL of the image
    String downloadUrl = await storageSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<bool> _submitForm() async {
    final name = _nameController.text.trim();
    final number = _numberController.text.trim();
    final address = _addressController.text.trim();
    final password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        final email = user?.email;

        if (email != null) {
          final cred =
              EmailAuthProvider.credential(email: email, password: password);
          await user?.reauthenticateWithCredential(cred);
          await user?.updateDisplayName(name);

          // Update user document in Firestore
          final userRef =
              FirebaseFirestore.instance.collection('users').doc(user?.uid);
          await userRef
              .update({'name': name, 'address': address, 'number': number});

          // Update user information in Provider
          if (mounted) {
            Provider.of<UserData>(context, listen: false).setUser(
                user!, {'name': name, 'address': address, 'number': number});
          }
          return true;
        } else {
          return false;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          setState(() => error = "User does not match with password");
        } else {
          setState(() => error = "An error has occurred");
        }
        return false;
      }
    } else {
      return false;
    }
  }

  void refresh() {
    globalUser = Provider.of<UserData>(context, listen: false).user ??
        FirebaseAuth.instance.currentUser;
    var userData = Provider.of<UserData>(context, listen: false).userData;

    if (userData == null) {
      final userRef = FirebaseFirestore.instance.collection('users');
      final query = userRef
          .doc(globalUser!.uid)
          .get()
          .then((value) => {userData = value.data()});
    }

    setState(() {
      _nameController.text = globalUser?.displayName ?? '';
      _numberController.text = userData?['number'] ?? '';
      _addressController.text = userData?['address'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null &&
        _nameController.text == '') {
      print('refreshing');
      refresh();
    }

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 120),
          child: Form(
            key: _formKey,
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
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Choose Image"),
                              content: SingleChildScrollView(
                                  child: ListBody(
                                children: <Widget>[
                                  Text(defaultTargetPlatform ==
                                              TargetPlatform.android ||
                                          defaultTargetPlatform ==
                                              TargetPlatform.iOS
                                      ? 'Where would you like to pick your image from?'
                                      : "Feature Unsupported")
                                ],
                              )),
                              actions: defaultTargetPlatform ==
                                          TargetPlatform.android ||
                                      defaultTargetPlatform ==
                                          TargetPlatform.iOS
                                  ? <Widget>[
                                      TextButton(
                                          onPressed: () async {
                                            final pickedFile =
                                                await ImagePicker().pickImage(
                                                    source: ImageSource.camera);

                                            if (pickedFile != null) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              if (mounted) {
                                                Navigator.of(context).pop();
                                              }
                                              String link =
                                                  await uploadImageToFirebase(
                                                      File(pickedFile.path));

                                              // update user image
                                              final user = FirebaseAuth
                                                  .instance.currentUser;

                                              await user!.updatePhotoURL(link);

                                              setState(() {
                                                globalUser = FirebaseAuth
                                                    .instance.currentUser;
                                                isLoading = false;
                                              });
                                            } else {
                                              if (mounted) {
                                                Navigator.of(context).pop();
                                              }
                                            }
                                          },
                                          child: Text('Camera')),
                                      TextButton(
                                          onPressed: () async {
                                            final pickedFile =
                                                await ImagePicker().pickImage(
                                                    source:
                                                        ImageSource.gallery);

                                            if (pickedFile != null) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              if (mounted) {
                                                Navigator.of(context).pop();
                                              }
                                              String link =
                                                  await uploadImageToFirebase(
                                                      File(pickedFile.path));

                                              // update user image
                                              final user = FirebaseAuth
                                                  .instance.currentUser;

                                              await user!.updatePhotoURL(link);

                                              setState(() {
                                                globalUser = FirebaseAuth
                                                    .instance.currentUser;
                                                isLoading = false;
                                              });
                                            } else {
                                              if (mounted) {
                                                Navigator.of(context).pop();
                                              }
                                            }
                                          },
                                          child: Text('Library'))
                                    ]
                                  : <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'))
                                    ],
                            );
                          });
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child:
                              globalUser != null && globalUser!.photoURL != null
                                  ? Image.network(globalUser!.photoURL!,
                                      fit: BoxFit.cover)
                                  : Image.asset(
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
                  "Hi there, User!",
                  style: Helper.getTheme(context).headline4!.copyWith(
                        color: AppColor.primary,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                    child: const Text("Sign Out"),
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Are you sure?"),
                              content: SingleChildScrollView(
                                  child: ListBody(
                                children: const <Widget>[
                                  Text('Are you sure you want to sign out?')
                                ],
                              )),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      // Sign out from firebaseauth
                                      FirebaseAuth.instance.signOut();

                                      // Clean provider
                                      Provider.of<UserData>(context,
                                              listen: false)
                                          .clearUser();

                                      // Pop back to splash screen
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              LandingScreen.routeName);
                                      print('hello');
                                    },
                                    child: Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No'))
                              ],
                            );
                          });
                    }),
                const SizedBox(
                  height: 40,
                ),
                FoodyTextInput(
                    label: "Name",
                    textEditingController: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                FoodyTextInput(
                    label: "Mobile No",
                    textEditingController: _numberController,
                    validator: (value) {
                      final numericRegex = RegExp(r'^\d+$');
                      if (value!.isEmpty) {
                        return "Please enter your mobile no";
                      } else if (!numericRegex.hasMatch(value)) {
                        return "Your mobile number is invalid";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                FoodyTextInput(
                    label: "Address",
                    textEditingController: _addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "PLease enter your current address";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                FoodyTextInput(
                  label: "Enter your password before saving changes",
                  obscureText: true,
                  textEditingController: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
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
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (await _submitForm()) {
                        setState(() {
                          error = "Successfully Changed!";
                        });
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
