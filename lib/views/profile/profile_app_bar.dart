import 'package:fire_cars/services/authentification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileAppBar extends StatelessWidget {
  final User? user;
  const ProfileAppBar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height * 0.40;
    return SliverAppBar(
      expandedHeight: heightDevice,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(user!.photoURL!),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.transparent],
                begin: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '${user!.displayName}\n',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black),
              ),
              TextSpan(
                text: '${user!.email}',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthService().signOut();
          },
          tooltip: 'Logout',
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }
}
