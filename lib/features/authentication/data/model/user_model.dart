import 'dart:convert';

import 'package:flutter_node_practice/core/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.number,
    required super.uid,
    required super.userId,
    required super.createdOn,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      number: map['number'],
      userId: map['userId'],
      uid: map['uid'],
      createdOn: map['createdOn'],
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'number': number,
      'userId': userId,
      'uid': uid,
      'createdOn': createdOn,
    };
  }

  @override
  String toJson() => json.encode(toMap());
}
