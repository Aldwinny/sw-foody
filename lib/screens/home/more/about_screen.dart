import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';

/// Refactor Complete
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  static const routeName = "/aboutScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Helper.getScreenHeight(context),
          width: Helper.getScreenWidth(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const FoodyAppBar(label: "About Us"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: const [
                      AboutCard(label: "Our own text"),
                      AboutCard(),
                      AboutCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  const AboutCard(
      {super.key,
      this.label =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      this.padding = const EdgeInsets.symmetric(vertical: 7)});

  final String label;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 5,
            backgroundColor: AppColor.red,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
