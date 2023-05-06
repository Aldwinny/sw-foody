import 'package:firebase_auth/firebase_auth.dart';

class SigninService {
  static final Auth = FirebaseAuth.instance;

  SigninService();

  static bool checkSignin() {
    bool loggedin = false;
    Auth.idTokenChanges().listen((User? user) {
      loggedin = user != null;
    });
    return loggedin;
  }
}
