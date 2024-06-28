// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_node_practice/core/entities/user_entity.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.user,
  });
  UserEntity user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.user.name.toString(),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
