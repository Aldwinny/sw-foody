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
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CircleAvatar(
                    child: Image.asset(
                        Helper.getAssetName("foody_logo.png", "logo"),
                        fit: BoxFit.cover),
                    radius: 120,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: const [
                      Text(
                        "To address this gap in the market, this study aims to develop a local food delivery application that caters specifically to the needs of independent restaurants. By focusing on the local market, the application aims to provide a platform for smaller, independent restaurants to reach a broader customer base and compete with larger chain restaurants. Through the use of advanced technologies such as geolocation, real-time tracking, and order management systems, the application will improve the ordering and delivery process for both restaurants and customers. In summary, the COVID-19 pandemic has led to a significant increase in demand for food delivery services, creating an opportunity for the development of a local food delivery application. By examining the literature on food delivery applications and the unique needs of independent restaurants, this study aims to create an innovative and user-friendly application that benefits both restaurants and customers.",
                        textAlign: TextAlign.justify,
                      ),
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
