import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/foody_navbar.dart';

class InboxScreen extends StatelessWidget {
  static const routeName = "/inboxScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                      Expanded(
                        child: Text(
                          "Inbox",
                          style: Helper.getTheme(context).headline5,
                        ),
                      ),
                      Image.asset(
                        Helper.getAssetName("cart.png", "virtual"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const MailCard(
                  title: "MealMonkey Promotions",
                  description:
                      "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor ",
                  time: "6th July",
                ),
                const MailCard(
                  title: "MealMonkey Promotions",
                  description:
                      "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor ",
                  time: "6th July",
                  color: AppColor.placeholderBg,
                ),
                const MailCard(
                  title: "MealMonkey Promotions",
                  description:
                      "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor ",
                  time: "6th July",
                ),
                const MailCard(
                  title: "MealMonkey Promotions",
                  description:
                      "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor ",
                  time: "6th July",
                  color: AppColor.placeholderBg,
                ),
                const MailCard(
                  title: "MealMonkey Promotions",
                  description:
                      "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor ",
                  time: "6th July",
                ),
                const MailCard(
                  title: "MealMonkey Promotions",
                  description:
                      "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor ",
                  time: "6th July",
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            child: FoodyNavBar(
              menu: true,
            ),
          ),
        ],
      ),
    );
  }
}

class MailCard extends StatelessWidget {
  const MailCard({
    super.key,
    required this.time,
    required this.title,
    required this.description,
    this.color = Colors.white,
  });

  final String time;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        border: const Border(
          bottom: BorderSide(
            color: AppColor.placeholder,
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: AppColor.red,
            radius: 5,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColor.primary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(description),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
              Image.asset(Helper.getAssetName("star.png", "virtual"))
            ],
          ),
        ],
      ),
    );
  }
}
