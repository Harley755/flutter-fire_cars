import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Add_card_section.dart';
import 'home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [HomeAppBar(user: _user), AddCardSection(user: _user)],
        ),
      ),
    );
  }
}
