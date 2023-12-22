import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';
import 'package:project_reminder_medicine/widgets/custom_snackbar.dart';

class AuthFirebase extends GetxController {
  var firestoreC = Get.put(FirestoreFirebase());

  Future logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  bool checkLoginStatus() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackbarC.failedSnackbar(
            'user not found', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        SnackbarC.failedSnackbar(
            'wrong password', 'Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<bool> signUpWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      await user?.updateDisplayName(username);
      await user?.updateEmail(email);

      await firestoreC.createNewAccountFirestore(username, user!.uid, email);
      signInUserWithEmailAndPassword(email, password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The pasword provided is to weak');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
      return false;
    }
  }
}
