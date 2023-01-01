import 'package:fire_cars/components.dart';
import 'package:fire_cars/services/authentification.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/sign_button.dart';

class Login extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authServiceProvider = ref.watch(authService);

    var heightDevice = MediaQuery.of(context).size.height * .40;
    var widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: heightDevice,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/mustang.png'),
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              OpenSans(
                text: "Fire cars",
                color: Colors.black54,
                size: 40.0,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                child: OpenSans(
                  text:
                      "Découvrer et partager les meilleurs voitures de luxe de 2022",
                  size: 23.0,
                  textAlignCenter: TextAlign.center,
                ),
              ),
              SizedBox(height: 60.0),
              SignInButton(
                width: widthDevice / 0.5,
                buttonType: ButtonType.google,
                btnColor: Colors.amber,
                btnText: 'Connectez-vous avec Google',
                btnTextColor: Colors.black,
                buttonSize: ButtonSize.large,
                onPressed: () async {
                  await authServiceProvider.signInWithGoogle(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
