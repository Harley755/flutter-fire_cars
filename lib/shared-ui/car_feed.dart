import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_cars/components.dart';
import 'package:fire_cars/model/carModel.dart';
import 'package:flutter/material.dart';

class CarFeed extends StatelessWidget {
  final Car? car;
  final String? userID;
  final DocumentSnapshot? documentSnapshot;
  const CarFeed({
    super.key,
    this.car,
    this.userID,
    this.documentSnapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            image: DecorationImage(
              image: NetworkImage(car!.carUrlImg!),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Row(
            children: [
              OpenSans(
                text: car!.carName,
                size: 16.0,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        )
      ],
    );
  }
}
