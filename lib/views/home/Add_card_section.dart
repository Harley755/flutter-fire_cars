import 'package:fire_cars/components.dart';
import 'package:fire_cars/views/home/show_car_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddCardSection extends HookConsumerWidget {
  final User? user;
  const AddCardSection({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showCarDialog(BuildContext context, User user) {
      CarDialog(user: user).ShowCardDialog(context, ImageSource.gallery, user);
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OpenSans(text: "Salut", size: 16.0),
                  OpenSans(
                    text: "${user!.displayName}",
                    size: 18.0,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: 40.0,
                    margin: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        return showCarDialog(context, user!);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
