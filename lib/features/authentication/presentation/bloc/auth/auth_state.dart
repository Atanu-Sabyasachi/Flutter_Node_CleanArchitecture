import 'package:equatable/equatable.dart';

import 'package:flutter_node_practice/core/entities/user_entity.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthSuccessState extends AuthState {
  AuthSuccessState({
    required this.message,
    required this.statusCode,
    required this.user,
  });

  final String message;
  final int statusCode;
  final UserEntity user;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthFailureState extends AuthState {
  AuthFailureState({
    required this.statusCode,
    required this.message,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => throw UnimplementedError();
}
