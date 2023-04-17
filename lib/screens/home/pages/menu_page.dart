import 'package:flutter/material.dart';
import 'package:foody_app/screens/home/menu/dessert_screen.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';
import 'package:foody_app/widgets/foody_searchbar.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          const FoodyAppBar(
            label: "Menu",
            useBackButton: false,
            useCart: true,
          ),
          const SizedBox(
            height: 20,
          ),
          const FoodySearchBar(title: "Search Food"),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: Helper.getScreenHeight(context) * 0.6,
            width: Helper.getScreenWidth(context),
            child: Stack(
              children: [
                Container(
                  width: 100,
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      color: AppColor.red),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MenuCard(
                          imageShape: ClipOval(
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset(
                                Helper.getAssetName("western2.jpg", "real"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          name: "Food",
                          count: "120",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MenuCard(
                          imageShape: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset(
                                Helper.getAssetName("coffee2.jpg", "real"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          name: "Beverage",
                          count: "220",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(DessertScreen.routeName);
                          },
                          child: MenuCard(
                            imageShape: ClipPath(
                              clipper: CustomTriangle(),
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: Image.asset(
                                  Helper.getAssetName("dessert.jpg", "real"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            name: "Desserts",
                            count: "135",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MenuCard(
                          imageShape: ClipPath(
                            clipper: CustomDiamond(),
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset(
                                Helper.getAssetName("hamburger3.jpg", "real"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          name: "Promotions",
                          count: "25",
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.name,
    required this.count,
    required this.imageShape,
  });

  final String name;
  final String count;
  final Widget imageShape;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 80,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.placeholder,
                offset: Offset(0, 5),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Helper.getTheme(context).headline4!.copyWith(
                      color: AppColor.primary,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text("$count items")
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Align(
            alignment: Alignment.centerLeft,
            child: imageShape,
          ),
        ),
        SizedBox(
          height: 80,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 40,
              width: 40,
              decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      color: AppColor.placeholder,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                    )
                  ]),
              child: Image.asset(
                Helper.getAssetName("next_filled.png", "virtual"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlpoint = Offset(size.width * 0, size.height * 0.5);
    Offset endpoint = Offset(size.width * 0.2, size.height * 0.85);
    Offset controlpoint2 = Offset(size.width * 0.33, size.height);
    Offset endpoint2 = Offset(size.width * 0.6, size.height * 0.9);
    Offset controlpoint3 = Offset(size.width * 1.4, size.height * 0.5);
    Offset endpoint3 = Offset(size.width * 0.6, size.height * 0.1);
    Offset controlpoint4 = Offset(size.width * 0.33, size.height * 0);
    Offset endpoint4 = Offset(size.width * 0.2, size.height * 0.15);

    Path path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.15)
      ..quadraticBezierTo(
        controlpoint.dx,
        controlpoint.dy,
        endpoint.dx,
        endpoint.dy,
      )
      ..quadraticBezierTo(
        controlpoint2.dx,
        controlpoint2.dy,
        endpoint2.dx,
        endpoint2.dy,
      )
      ..quadraticBezierTo(
        controlpoint3.dx,
        controlpoint3.dy,
        endpoint3.dx,
        endpoint3.dy,
      )
      ..quadraticBezierTo(
        controlpoint4.dx,
        controlpoint4.dy,
        endpoint4.dx,
        endpoint4.dy,
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomDiamond extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.1000000, size.height * 0.4400000);
    path.quadraticBezierTo(size.width * 0.0243800, size.height * 0.5247000,
        size.width * 0.1000000, size.height * 0.6000000);
    path.quadraticBezierTo(size.width * 0.3550000, size.height * 0.8250000,
        size.width * 0.4400000, size.height * 0.9000000);
    path.quadraticBezierTo(size.width * 0.5140600, size.height * 0.9574800,
        size.width * 0.5800000, size.height * 0.9000000);
    path.quadraticBezierTo(size.width * 0.8200000, size.height * 0.6450000,
        size.width * 0.9000000, size.height * 0.5600000);
    path.quadraticBezierTo(size.width * 0.9500400, size.height * 0.5009400,
        size.width * 0.9000000, size.height * 0.4200000);
    path.quadraticBezierTo(size.width * 0.6450000, size.height * 0.1800000,
        size.width * 0.5600000, size.height * 0.1000000);
    path.quadraticBezierTo(size.width * 0.5029400, size.height * 0.0446800,
        size.width * 0.4200000, size.height * 0.1000000);
    path.quadraticBezierTo(size.width * 0.3400000, size.height * 0.1850000,
        size.width * 0.1000000, size.height * 0.4400000);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
