import 'package:fire_cars/auth/login.dart';
import 'package:fire_cars/views/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _user = Provider.of<User?>(context);
    final _user = FirebaseAuth.instance.currentUser;
    return _user == null ? Login() : HomePage();
  }
}
