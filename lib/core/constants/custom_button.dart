// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_node_practice/core/constants/custom_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.child,
    this.height,
    this.width,
    required this.onPressed,
  });
  double? height, width;
  Widget? child;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width ?? 100,
      decoration: BoxDecoration(
          color: CustomColor.actionColor,
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: const Size(150, 70),
          backgroundColor: CustomColor.actionColor,
          side: const BorderSide(color: CustomColor.actionColor, width: 5),
        ),
        onPressed: onPressed,
        child: child ??
            Text(
              "OK",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.merge(const TextStyle(color: CustomColor.white)),
            ),
      ),
    );
  }
}
