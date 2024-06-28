import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_node_practice/core/entities/user_entity.dart';
import 'package:flutter_node_practice/core/usecase/no_params.dart';
import 'package:flutter_node_practice/core/usecase/user_params.dart';
import 'package:flutter_node_practice/features/authentication/domain/usecase/current_user.dart';

import 'package:flutter_node_practice/features/authentication/domain/usecase/signup_usecase.dart';
import 'package:flutter_node_practice/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:flutter_node_practice/features/authentication/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final CurrentUser _currentUser;

  AuthBloc({
    required SignUpUseCase signUpUseCase,
    required CurrentUser currentUser,
  })  : _signUpUseCase = signUpUseCase,
        _currentUser = currentUser,
        super(AuthInitialState()) {
    on<AuthSignUpEvent>(signUpEventCall);
    on<AuthLoggedIn>(onAuthLoggedInEventCall);
  }

  Future<void> signUpEventCall(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await _signUpUseCase(UserParams(user: event.user));
    result.fold(
      (failure) => emit(
        AuthFailureState(
          statusCode: failure.statusCode,
          message: failure.message,
        ),
      ),
      (success) {
        UserEntity user = UserEntity.fromMap(success["user"]);
        emit(
          AuthSuccessState(
            statusCode: 200, // success[""],
            message: success["message"],
            user: user,
          ),
        );
      },
    );
  }

  void onAuthLoggedInEventCall(
    AuthLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _currentUser(NoParams());
    result.fold(
      (failure) => AuthFailureState(
        statusCode: failure.statusCode,
        message: failure.message,
      ),
      (success) => AuthSuccessState(
        statusCode: 200,
        message: "User found !",
        user: success,
      ),
    );
  }
}
