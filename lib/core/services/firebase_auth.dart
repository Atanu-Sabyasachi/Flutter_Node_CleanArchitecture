// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_node_practice/core/services/data_helper.dart';

class FirebaseAuthentication {
  FirebaseAuth auth = FirebaseAuth.instance;

  // SIGNIN
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

  // SIGNUP
  Future<String> emailSignUp(String userEmail, String password) async {
    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: password,
      );
      String uid = userCred.user?.uid ?? "";
      //await sendEmailVerification();
      return uid;
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

  // CHECK IF EMAIL IS ALREADY REGISTERED
  Future<bool> isEmailAlreadyRegistered(String email) async {
    try {
      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  // LOGOUT
  dynamic logout() async {
    try {
      await auth.signOut();
      DataHelper().setJwtToken = "";
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', 'null');
      // prefs.clear();
    } catch (e) {
      print(e);
    }
  }

  // SEND EMAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    User? user = auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // RESET PASSWORD
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Password reset error: $e');
    }
  }

  // UPDATE USER PROFILE
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    User? user = auth.currentUser;
    try {
      await user?.updateProfile(displayName: displayName, photoURL: photoURL);
      await user?.reload();
      user = auth.currentUser;
    } catch (e) {
      print('Update profile error: $e');
    }
  }

  // DELETE USER
  Future<void> deleteUser() async {
    User? user = auth.currentUser;
    try {
      await user?.delete();
    } catch (e) {
      print('Delete user error: $e');
    }
  }

  // GET CURRENT USER
  User? getCurrentUser() {
    return auth.currentUser;
  }

  // CHECK EMAIL VERIFICATION STATUS
  Future<bool> isEmailVerified() async {
    User? user = auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }
}
