import 'package:fire_cars/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final User? user;
  const HomeAppBar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: OpenSans(
        text: "Fire Cars",
        size: 30.0,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0.8,
      forceElevated: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
          ),
        ),
      ],
    );
  }
}
