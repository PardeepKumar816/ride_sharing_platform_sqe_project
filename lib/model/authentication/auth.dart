

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

Future<dynamic> registerWithUsernameAndPassword(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      if (kDebugMode) {
        print('No user found for that email.');
      }
    } else if (e.code == 'wrong-password') {
      if (kDebugMode) {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  } catch (e) {
    if (kDebugMode) {
      print("$e");
    }
  }
}


Future<dynamic> loginWithUsernameAndPassword(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      if (kDebugMode) {
        print('No user found for that email.');
      }
    } else if (e.code == 'wrong-password') {
      if (kDebugMode) {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  } catch (e) {
    if (kDebugMode) {
      print("$e");
    }
  }
}
