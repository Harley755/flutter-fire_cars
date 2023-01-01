import 'package:fire_cars/views/profile/profile_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser;
    var logger = Logger();
    logger.d(_user);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [ProfileAppBar(user: _user)],
        ),
      ),
    );
  }
}
