import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/screens/auth/signin_screen.dart';
import 'package:foody_app/screens/auth/signup_screen.dart';
import 'package:foody_app/screens/home/all_items_screen.dart';
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
import 'package:foody_app/screens/home/more/transaction_history_screen.dart';
import 'package:foody_app/screens/landing_screen.dart';
import 'package:foody_app/screens/splash_screen.dart';

import 'package:foody_app/shared/colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() async {
    if (kIsWeb) {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    }
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
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

            // Home Screen
            IntroScreen.routeName: (context) => const IntroScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),

            ItemScreen.routeName: (context) => const ItemScreen(),
            DessertScreen.routeName: (context) => const DessertScreen(),
            NotificationScreen.routeName: (context) =>
                const NotificationScreen(),

            AllItemsScreen.routeName: (context) => const AllItemsScreen(),
            AboutScreen.routeName: (context) => const AboutScreen(),
            InboxScreen.routeName: (context) => const InboxScreen(),
            MyOrderScreen.routeName: (context) => const MyOrderScreen(),
            TransactionHistoryScreen.routeName: (context) =>
                const TransactionHistoryScreen(),
            CheckoutScreen.routeName: (context) => const CheckoutScreen(),
            ChangeAddressScreen.routeName: (context) =>
                const ChangeAddressScreen(),
          }),
    );
  }
}

class UserData with ChangeNotifier {
  User? _user;
  Map<String, dynamic>? userData = {};

  User? get user => _user;

  void setUser(User user, Map<String, dynamic>? info) {
    _user = user;
    userData = info;
  }

  void clearUser() {
    _user = null;
    userData = {};
  }
}
