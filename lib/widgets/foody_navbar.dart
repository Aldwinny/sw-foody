import 'package:flutter/material.dart';
import 'package:foody_app/screens/home/home_screen.dart';
import 'package:foody_app/screens/home/menu/dessert_screen.dart';
import 'package:foody_app/shared/colors.dart';

import '../utils/helper.dart';

@Deprecated("Replace")
class FoodyNavBar extends StatelessWidget {
  final bool home;
  final bool menu;
  final bool offer;
  final bool profile;
  final bool more;

  const FoodyNavBar(
      {super.key,
      this.home = false,
      this.menu = false,
      this.offer = false,
      this.profile = false,
      this.more = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: Helper.getScreenWidth(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            // child: ClipShadow(
            //   boxShadow: [
            //     BoxShadow(
            //       color: AppColor.placeholder,
            //       offset: Offset(
            //         0,
            //         -5,
            //       ),
            //       blurRadius: 10,
            //     ),
            //   ],
            //   clipper: CustomNavBarClipper(),
            child: Container(
              height: 80,
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!menu) {
                        Navigator.of(context)
                            .pushReplacementNamed(DessertScreen.routeName);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        menu
                            ? Image.asset(
                                Helper.getAssetName(
                                    "more_filled.png", "virtual"),
                              )
                            : Image.asset(
                                Helper.getAssetName("more.png", "virtual"),
                              ),
                        menu
                            ? const Text("Menu",
                                style: TextStyle(color: AppColor.red))
                            : const Text("Menu"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!offer) {
                        Navigator.of(context)
                            .pushReplacementNamed(DessertScreen.routeName);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        offer
                            ? Image.asset(
                                Helper.getAssetName(
                                    "bag_filled.png", "virtual"),
                              )
                            : Image.asset(
                                Helper.getAssetName("bag.png", "virtual"),
                              ),
                        offer
                            ? const Text("Offers",
                                style: TextStyle(color: AppColor.red))
                            : const Text("Offers"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!profile) {
                        Navigator.of(context)
                            .pushReplacementNamed(DessertScreen.routeName);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        profile
                            ? Image.asset(
                                Helper.getAssetName(
                                    "user_filled.png", "virtual"),
                              )
                            : Image.asset(
                                Helper.getAssetName("user.png", "virtual"),
                              ),
                        profile
                            ? const Text("Profile",
                                style: TextStyle(color: AppColor.red))
                            : const Text("Profile"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!more) {
                        Navigator.of(context)
                            .pushReplacementNamed(DessertScreen.routeName);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        more
                            ? Image.asset(
                                Helper.getAssetName(
                                    "menu_filled.png", "virtual"),
                              )
                            : Image.asset(
                                Helper.getAssetName("menu.png", "virtual"),
                              ),
                        more
                            ? const Text("Profile",
                                style: TextStyle(color: AppColor.red))
                            : const Text("More"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                elevation: 5,
                backgroundColor: home ? AppColor.red : AppColor.placeholder,
                onPressed: () {
                  if (!home) {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  }
                },
                child: Image.asset(
                    Helper.getAssetName("home_white.png", "virtual")),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class CustomNavBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(size.width * 0.3, 0);
//     path.quadraticBezierTo(
//       size.width * 0.375,
//       0,
//       size.width * 0.375,
//       size.height * 0.1,
//     );
//     path.cubicTo(
//       size.width * 0.4,
//       size.height * 0.9,
//       size.width * 0.6,
//       size.height * 0.9,
//       size.width * 0.625,
//       size.height * 0.1,
//     );
//     path.quadraticBezierTo(
//       size.width * 0.625,
//       0,
//       size.width * 0.7,
//       0.1,
//     );
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(0, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
