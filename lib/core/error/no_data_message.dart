import 'package:flutter/material.dart';

class NoDataMessage extends StatelessWidget {
  final String message;

  const NoDataMessage({super.key, this.message = "No data available !"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
