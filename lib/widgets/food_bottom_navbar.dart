import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';

class FoodyBottomNavigationBar extends StatelessWidget {
  const FoodyBottomNavigationBar(
      {super.key, this.index = 0, required this.onPress});

  final int index;
  final TextStyle activeTextStyle =
      const TextStyle(color: AppColor.red, fontWeight: FontWeight.bold);
  final void Function(int value) onPress;

  Color getColor(int index) {
    return index == this.index ? AppColor.red : AppColor.placeholder;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            NavigationButton(
              label: "Home",
              icon: Icon(index == 0 ? Icons.home : Icons.home_outlined,
                  color: getColor(0)),
              textStyle: index == 0 ? activeTextStyle : null,
              onTap: () => onPress(0),
            ),
            NavigationButton(
              label: "Offers",
              icon: Icon(
                  index == 1 ? Icons.shopping_bag : Icons.shopping_bag_outlined,
                  color: getColor(1)),
              textStyle: index == 1 ? activeTextStyle : null,
              onTap: () => onPress(1),
            ),
            NavigationButton(
              label: "Profile",
              icon: Icon(
                  index == 3
                      ? Icons.account_circle
                      : Icons.account_circle_outlined,
                  color: getColor(2)),
              textStyle: index == 2 ? activeTextStyle : null,
              onTap: () => onPress(2),
            ),
            NavigationButton(
              label: "More",
              icon: Icon(index == 3 ? Icons.more : Icons.more_outlined,
                  color: getColor(3)),
              textStyle: index == 3 ? activeTextStyle : null,
              onTap: () => onPress(3),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton(
      {super.key,
      required this.label,
      required this.icon,
      this.textStyle,
      this.onTap});

  final Widget icon;
  final String label;
  final TextStyle? textStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: <Widget>[
          icon,
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              label,
              style: textStyle,
            ),
          )
        ],
      ),
    );
  }
}
