import 'package:flutter/material.dart';
import 'package:foody_app/screens/home/more/about_screen.dart';
import 'package:foody_app/screens/home/more/inbox_screen.dart';
import 'package:foody_app/screens/home/more/my_order_screen.dart';
import 'package:foody_app/screens/home/more/notification_screen.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/foody_navbar.dart';

/// Refactor Complete
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 30),
                      child: Row(
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
                    ),
                    MoreCard(
                      image: Image.asset(
                        Helper.getAssetName("shopping_bag.png", "virtual"),
                      ),
                      name: "My Orders",
                      handler: () {
                        Navigator.of(context)
                            .pushNamed(MyOrderScreen.routeName);
                      },
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
                    MoreCard(
                      image: Image.asset(
                        Helper.getAssetName("mail.png", "virtual"),
                      ),
                      name: "Inbox",
                      handler: () {
                        Navigator.of(context).pushNamed(InboxScreen.routeName);
                      },
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
                  ]),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
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
  const MoreCard(
      {super.key,
      required this.name,
      this.image,
      this.isNoti = false,
      this.handler,
      this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 7)});

  final String name;
  final Image? image;
  final bool isNoti;
  final Function()? handler;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        color: AppColor.placeholder.withAlpha(50),
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: handler,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColor.placeholder.withAlpha(250),
                    child: image),
              ),
              Text(name),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if (isNoti)
                          const Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: CircleAvatar(
                              radius: 12,
                              child: Center(
                                child: Text(
                                  "69",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColor.placeholder.withAlpha(75),
                            child: const Icon(Icons.arrow_forward_ios,
                                size: 19, color: Colors.black))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
