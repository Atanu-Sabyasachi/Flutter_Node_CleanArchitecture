import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_node_practice/core/constants/custom_colors.dart';
import 'package:flutter_node_practice/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_node_practice/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter_node_practice/init_dependencies.dart';
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

  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //context.read<AuthBloc>().add(AuthLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Montserrat",
        colorScheme: const ColorScheme.dark(
          background: Color.fromARGB(255, 3, 1, 30),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
