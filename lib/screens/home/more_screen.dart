import 'package:flutter/material.dart';
import 'package:foody_app/screens/home/more/about_screen.dart';
import 'package:foody_app/screens/home/more/inbox_screen.dart';
import 'package:foody_app/screens/home/more/my_order_screen.dart';
import 'package:foody_app/screens/home/more/notification_screen.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/foody_navbar.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = "/moreScreen";
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "More",
                        style: Helper.getTheme(context).headline5,
                      ),
                      Image.asset(
                        Helper.getAssetName("cart.png", "virtual"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Helper.getAssetName("shopping_bag.png", "virtual"),
                    ),
                    name: "My Orders",
                    handler: () {
                      Navigator.of(context).pushNamed(MyOrderScreen.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Helper.getAssetName("noti.png", "virtual"),
                    ),
                    name: "Notifications",
                    isNoti: true,
                    handler: () {
                      Navigator.of(context)
                          .pushNamed(NotificationScreen.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Helper.getAssetName("mail.png", "virtual"),
                    ),
                    name: "Inbox",
                    handler: () {
                      Navigator.of(context).pushNamed(InboxScreen.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Helper.getAssetName("info.png", "virtual"),
                    ),
                    name: "About Us",
                    handler: () {
                      Navigator.of(context).pushNamed(AboutScreen.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            child: FoodyNavBar(
              more: true,
            ),
          )
        ],
      ),
    );
  }
}

class MoreCard extends StatelessWidget {
  const MoreCard({
    super.key,
    required this.name,
    this.image,
    this.isNoti = false,
    this.handler,
  });

  final String name;
  final Image? image;
  final bool isNoti;
  final Function()? handler;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handler,
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(
                right: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColor.placeholderBg,
              ),
              child: Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColor.placeholder,
                      ),
                      child: image),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 30,
                width: 30,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: AppColor.placeholderBg,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.secondary,
                  size: 17,
                ),
              ),
            ),
            if (isNoti)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(
                    right: 50,
                  ),
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      "15",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
