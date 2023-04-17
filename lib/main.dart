import 'package:flutter/material.dart';
import 'package:foody_app/screens/auth/forgot_password_screen.dart';
import 'package:foody_app/screens/auth/signin_screen.dart';
import 'package:foody_app/screens/auth/signup_screen.dart';
import 'package:foody_app/screens/home/home_screen.dart';
import 'package:foody_app/screens/home/intro_screen.dart';
import 'package:foody_app/screens/home/item_screen.dart';
import 'package:foody_app/screens/home/menu/dessert_screen.dart';
import 'package:foody_app/screens/home/more/about_screen.dart';
import 'package:foody_app/screens/home/more/change_address_screen.dart';
import 'package:foody_app/screens/home/more/checkout_screen.dart';
import 'package:foody_app/screens/home/more/inbox_screen.dart';
import 'package:foody_app/screens/home/more/my_order_screen.dart';
import 'package:foody_app/screens/home/more/notification_screen.dart';
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
        debugShowCheckedModeBanner: false,
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

          // TODO: Categorize
          ItemScreen.routeName: (context) => const ItemScreen(),
          DessertScreen.routeName: (context) => const DessertScreen(),
          NotificationScreen.routeName: (context) => const NotificationScreen(),
          AboutScreen.routeName: (context) => const AboutScreen(),
          InboxScreen.routeName: (context) => const InboxScreen(),
          MyOrderScreen.routeName: (context) => const MyOrderScreen(),
          CheckoutScreen.routeName: (context) => const CheckoutScreen(),
          ChangeAddressScreen.routeName: (context) =>
              const ChangeAddressScreen(),
        });
  }
}
