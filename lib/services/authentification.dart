import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../components.dart';

final authService =
    ChangeNotifierProvider.autoDispose<AuthService>((ref) => AuthService());

class AuthService extends ChangeNotifier {
  var logger = Logger();
  bool isSignedIn = false;

  final _auth = FirebaseAuth.instance;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  // CHECK IF SIGNED IN
  Future<void> isLoggedIn() async {
    await _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isSignedIn = false;
      } else {
        isSignedIn = true;
      }
    });
    notifyListeners();
  }

  // CONNEXION AVEC GOOGLE
  Future<void> signInWithGoogle(BuildContext context) async {
    // Declenche le flux d'authentification
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn().onError((error, stackTrace) => DialogBox(
              context,
              error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
            ));

    // Obtenir les details d'autorisation de la demande
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Créer un nouvel identifiant
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Une fois connecté, renvoyez l'identifiant de l'utilisateur
    await _auth.signInWithCredential(credential).then((value) {
      logger.d("Google successfully");
    }).onError((error, stackTrace) {
      logger.d("Google Sign in error $error");
      DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });
  }

  // LOGOUT
  Future<void> signOut() async {
    await _auth
        .signOut()
        .then((value) => logger.d("Logout done"))
        .onError((error, stackTrace) => logger.d(error));
  }
}
