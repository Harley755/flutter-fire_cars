import 'package:fire_cars/components.dart';
import 'package:fire_cars/views/profile/profile_app_bar.dart';
import 'package:fire_cars/views/shared-ui/car_list.dart';
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
          slivers: [
            ProfileAppBar(user: _user),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.0,
                      left: 16.0,
                      bottom: 12.0,
                    ),
                    child: OpenSans(
                      text: "Vos voitures Favorites",
                      size: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
            CarList(pageName: 'Profile', userID: _user!.uid),
          ],
        ),
      ),
    );
  }
}
