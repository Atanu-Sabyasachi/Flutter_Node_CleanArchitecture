import 'package:flutter/material.dart';
import 'package:flutter_node_practice/core/constants/custom_button.dart';
import 'package:flutter_node_practice/core/constants/custom_colors.dart';
import 'package:flutter_node_practice/features/authentication/presentation/pages/signup_page.dart';
import 'package:flutter_node_practice/features/authentication/presentation/widgets/auth_form_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(),
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
              height: 400,
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
                      "Login",
                      style: TextStyle(
                        color: CustomColor.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      child: const Text(
                        "Login",
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
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account ?"),
                const SizedBox(width: 5),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: CustomColor.actionColor,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
