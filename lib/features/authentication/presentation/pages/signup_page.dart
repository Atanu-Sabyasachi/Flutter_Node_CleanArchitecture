import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_node_practice/core/common/widgets/message.dart';
import 'package:flutter_node_practice/core/constants/custom_button.dart';
import 'package:flutter_node_practice/core/constants/custom_colors.dart';
import 'package:flutter_node_practice/core/entities/user_entity.dart';
import 'package:flutter_node_practice/core/services/firebase_auth.dart';
import 'package:flutter_node_practice/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_node_practice/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:flutter_node_practice/features/authentication/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_node_practice/features/authentication/presentation/widgets/auth_form_fields.dart';
import 'package:flutter_node_practice/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter_node_practice/features/home/presentation/pages/home_page.dart';
import 'package:uuid/uuid.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController(),
      _nameController = TextEditingController(),
      _numberController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (state.statusCode == 200) {
            Message().customMessage(
              context,
              500,
              state.message,
              CustomColor.primaryColor,
            );
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  user: state.user,
                ),
              ),
            );
          }
        } else if (state is AuthFailureState) {
          Navigator.pop(context);
          Message().customMessage(
            context,
            500,
            state.message,
            Colors.red,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login_background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          height: 600,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CustomColor.white.withOpacity(.3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: CustomColor.primaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AuthFormField(
                                  title: 'Name',
                                  hintText: 'name',
                                  isRequired: true,
                                  validator: (email) {
                                    return null;
                                  },
                                  controller: _nameController,
                                ),
                                const SizedBox(height: 30),
                                AuthFormField(
                                  title: 'Phone Number',
                                  hintText: 'Number',
                                  isRequired: true,
                                  validator: (email) {
                                    return null;
                                  },
                                  controller: _numberController,
                                ),
                                const SizedBox(height: 30),
                                AuthFormField(
                                  title: 'Email',
                                  hintText: 'email',
                                  isRequired: true,
                                  validator: (email) {
                                    return null;
                                  },
                                  controller: _emailController,
                                ),
                                const SizedBox(height: 30),
                                AuthFormField(
                                  title: 'Password',
                                  hintText: 'password',
                                  isRequired: true,
                                  validator: (email) {
                                    return null;
                                  },
                                  controller: _passwordController,
                                ),
                                const SizedBox(height: 30),
                                CustomButton(
                                  width: 120,
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: CustomColor.white,
                                    ),
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: ((context) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }));
                                    String email = _emailController.text;
                                    String password = _passwordController.text;

                                    String uid = await FirebaseAuthentication()
                                        .emailSignUp(email, password);

                                    UserEntity user = UserEntity(
                                      uid: uid,
                                      userId: const Uuid().v1(),
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      number: _numberController.text,
                                    );

                                    context.read<AuthBloc>().add(
                                          AuthSignUpEvent(user: user),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
