import 'package:fire_cars/auth/login.dart';
import 'package:fire_cars/services/authentification.dart';
import 'package:fire_cars/views/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Wrapper extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authServiceProvider = ref.watch(authService);
    authServiceProvider.isLoggedIn();

    if (authServiceProvider.isSignedIn == true) {
      return HomePage();
    } else {
      return Login();
    }
  }
}
