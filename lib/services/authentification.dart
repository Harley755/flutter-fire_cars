import 'package:fire_cars/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService extends ChangeNotifier {
  var logger = Logger();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // CONNEXION AVEC GOOGLE
  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn()
        .signIn()
        .onError((error, stackTrace) => DialogBox(
            context, error.toString().replaceAll(RegExp('\\[.*?\\]'), '')));

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _auth.signInWithCredential(credential).then((value) {
      logger.d("Google successfully");
    }).onError((error, stackTrace) {
      logger.d("Google Sign in error $error");
      DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });
  }

  // L'ETAT DE L'UTILISATEUR EN TEMPS REEL
  Stream<User?> get user => _auth.authStateChanges();

  // LOGOUT
  Future<void> signOut() async {
    await _auth
        .signOut()
        .then((value) => logger.d("Logout done"))
        .onError((error, stackTrace) => logger.d(error));
  }
}
