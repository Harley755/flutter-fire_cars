import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_cars/components.dart';
import 'package:fire_cars/model/carModel.dart';
import 'package:fire_cars/shared-ui/favorite_badge.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
    String formattingDate(Timestamp? timestamp) {
      initializeDateFormatting('fr', null);
      DateTime? dateTime = timestamp?.toDate();
      DateFormat dateFormat = DateFormat.MMMd('fr');
      return dateFormat.format(dateTime ?? DateTime.now());
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(car!.carUrlImg!),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            FavoriteBadge(car: car!, userID: userID),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OpenSans(
                    text: car!.carName!,
                    size: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  Poppins(text: 'De ${car!.carUserName}', size: 16.0),
                ],
              ),
              OpenSans(text: formattingDate(car!.carTimestamp), size: 15.0),
            ],
          ),
        )
      ],
    );
  }
}
