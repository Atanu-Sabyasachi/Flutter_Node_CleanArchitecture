import 'package:flutter/material.dart';
import 'package:flutter_node_practice/core/constants/custom_colors.dart';

class Message {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customMessage(
      BuildContext context, double screenWidth, String message, Color color) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 500,
        showCloseIcon: true,
        closeIconColor: CustomColor.white,
        duration: const Duration(seconds: 5),
        content: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: color,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
