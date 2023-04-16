import 'package:flutter/material.dart';
import 'package:foody_app/screens/auth/forgot_password_screen.dart';
import 'package:foody_app/screens/auth/signin_screen.dart';
import 'package:foody_app/screens/auth/signup_screen.dart';
import 'package:foody_app/screens/home/home_screen.dart';
import 'package:foody_app/screens/home/intro_screen.dart';
import 'package:foody_app/screens/home/menu/dessert_screen.dart';
import 'package:foody_app/screens/home/menu_screen.dart';
import 'package:foody_app/screens/home/more_screen.dart';
import 'package:foody_app/screens/home/offers_screen.dart';
import 'package:foody_app/screens/home/profile_screen.dart';
import 'package:foody_app/screens/landing_screen.dart';
import 'package:foody_app/screens/splash_screen.dart';

import 'package:foody_app/shared/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Foody',
        theme: ThemeData(
          fontFamily: "Metropolis",
          primarySwatch: Colors.red,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColor.red),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                  elevation: MaterialStateProperty.all(0))),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(AppColor.red))),
          textTheme: const TextTheme(
            headline3: TextStyle(
              color: AppColor.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              color: AppColor.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            headline5: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.normal,
              fontSize: 25,
            ),
            headline6: TextStyle(
              color: AppColor.primary,
              fontSize: 25,
            ),
            bodyText2: TextStyle(
              color: AppColor.secondary,
            ),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          LandingScreen.routeName: (context) => const LandingScreen(),

          // User Authentication
          SigninScreen.routeName: (context) => const SigninScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          ForgotPasswordScreen.routeName: (context) =>
              const ForgotPasswordScreen(),

          // Home Screen
          IntroScreen.routeName: (context) => const IntroScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),

          // Navbar routes
          MenuScreen.routeName: (context) => const MenuScreen(),
          OfferScreen.routeName: (context) => const OfferScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          MoreScreen.routeName: (context) => const MoreScreen(),

          // TODO: Categorize
          DessertScreen.routeName: (context) => const DessertScreen(),
        });
  }
}
