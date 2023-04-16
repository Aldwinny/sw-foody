import 'package:flutter/material.dart';

// Local Imports
import 'package:foody_app/shared/colors.dart';

class FoodyTextInput extends StatelessWidget {
  const FoodyTextInput(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      this.padding = const EdgeInsets.only(left: 20)});

  final String hintText;
  final EdgeInsets padding;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        decoration: const ShapeDecoration(
            shape: StadiumBorder(), color: AppColor.placeholderBg),
        child: TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColor.placeholder),
                contentPadding: padding)));
  }
}
