import 'package:flutter/material.dart';
import 'package:flutter_node_practice/main.dart';
import 'package:flutter_node_practice/service.dart';
import 'package:flutter_node_practice/user_model.dart';
import 'package:uuid/uuid.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 400,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onSaved: (name) {
                  setState(() {
                    nameController.text = name ?? "";
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 400,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onSaved: (name) {
                  setState(() {
                    emailController.text = name ?? "";
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 400,
              child: TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                    hintText: "Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onSaved: (name) {
                  setState(() {
                    numberController.text = name ?? "";
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text(
          "Add User",
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          UserModel user = UserModel(
            id: const Uuid().v1(),
            name: nameController.text,
            email: emailController.text,
            number: numberController.text,
          );
          //await ApiService().createUser(user);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        },
      ),
    );
  }
}
