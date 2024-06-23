// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_node_practice/data_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthenticationPage {
  FirebaseAuth auth = FirebaseAuth.instance;

  //SIGNIN
  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? inputuid = userCredential.user?.uid;
      return inputuid;
    } catch (e) {
      print('Sign in error: $e');
      return null;
    }
  }

//SIGNUP
  Future<String> emailSignUp(String userEmail, String password) async {
    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
        email: userEmail.toString(),
        password: password,
      );
      String uid = userCred.user?.uid ?? "";
      return uid;
      // user.uid = userCred.user?.uid;
      // PostUserAPI().signUp(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email already is in use';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user';
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return '';
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  //LogOut

  dynamic logout() async {
    try {
      auth.signOut();
      DataHelper().setJwtToken = "";
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', 'null');
      //prefs.clear();
    } catch (e) {
      print(e);
    }
  }
}
