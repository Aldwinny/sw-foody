import 'package:flutter/material.dart';

// Local Imports
import 'package:foody_app/shared/colors.dart';

class FoodyTextInput extends StatelessWidget {
  const FoodyTextInput({
    super.key,
    this.hintText,
    this.label,
    this.value,
    this.textEditingController,
    this.validator,
    this.obscureText = false,
    this.padding = const EdgeInsets.only(left: 20),
  });

  final String? hintText;
  final EdgeInsets padding;
  final bool obscureText;
  final String? label;
  final String? value;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        decoration: const ShapeDecoration(
            shape: StadiumBorder(), color: AppColor.placeholderBg),
        child: TextFormField(
            obscureText: obscureText,
            controller: textEditingController,
            validator: validator,
            initialValue: value,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                labelText: label,
                hintStyle: const TextStyle(color: AppColor.placeholder),
                contentPadding: padding)));
  }
}
