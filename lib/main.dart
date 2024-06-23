import 'package:flutter/material.dart';
import 'package:flutter_node_practice/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter_node_practice/firebase_auth.dart';
import 'package:flutter_node_practice/service.dart';
import 'package:flutter_node_practice/user_model.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAwybEqcjANQ8uBNsx3NfUHzNUGXYiAjZU",
        authDomain: "flutternodedemo.firebaseapp.com",
        projectId: "flutternodedemo",
        storageBucket: "flutternodedemo.appspot.com",
        messagingSenderId: "1076707671573",
        appId: "1:1076707671573:web:8f4932daf464068732981c",
        measurementId: "G-VJJ18BX0YM"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Montserrat",
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserModel> allUsers = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    var data = await ApiService().getUsers();
    setState(() {
      allUsers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Screen"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: allUsers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 214, 152, 255),
                  ),
                  child: Center(
                    child: Text(allUsers[index].name.toString()),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          "Go to next screen",
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          String signUpuid = await FirebaseAuthenticationPage()
              .emailSignUp("atanusj@gmail.com", "123456");
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const AddUser()),
          // );
        },
      ),
    );
  }
}
