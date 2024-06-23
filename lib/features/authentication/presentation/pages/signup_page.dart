import 'package:flutter/material.dart';
import 'package:flutter_node_practice/core/constants/custom_button.dart';
import 'package:flutter_node_practice/core/constants/custom_colors.dart';
import 'package:flutter_node_practice/features/authentication/presentation/widgets/auth_form_fields.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController(),
      _nameController = TextEditingController(),
      _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: CustomColor.secondaryColor,
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
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
