import 'package:flutter/material.dart';
import 'package:foody_app/screens/home/pages/home_page.dart';
import 'package:foody_app/screens/home/pages/more_page.dart';
import 'package:foody_app/screens/home/pages/offers_page.dart';
import 'package:foody_app/screens/home/pages/profile_page.dart';
import 'package:foody_app/widgets/food_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _index);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void transitionPage(value) {
    setState(() {
      _index = value;
    });
    _pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: FoodyBottomNavigationBar(
        index: _index,
        onPress: transitionPage,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) => setState(() => _index = index),
        children: const <Widget>[
          HomePage(),
          OffersPage(),
          ProfilePage(),
          MorePage(),
        ],
      ),
    );
  }
}
