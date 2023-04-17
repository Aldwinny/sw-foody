import 'package:flutter/material.dart';
import 'package:foody_app/utils/helper.dart';

class FoodyAppBar extends StatelessWidget {
  const FoodyAppBar({
    super.key,
    required this.label,
    this.useCart = false,
    this.useBackButton = true,
  });

  final String label;
  final bool useCart;
  final bool useBackButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (useBackButton)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
              ),
            ),
          Expanded(
            child: Text(
              label,
              style: Helper.getTheme(context).headline5,
            ),
          ),
          if (useCart)
            Image.asset(
              Helper.getAssetName("cart.png", "virtual"),
            ),
        ],
      ),
    );
  }
}
