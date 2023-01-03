import 'package:fire_cars/services/db_services.dart';
import 'package:fire_cars/shared-ui/car_feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/carModel.dart';

class CarList extends StatelessWidget {
  final String? userID;
  const CarList({super.key, this.userID});

  @override
  Widget build(BuildContext context) {
    // final viewModelProvider = ref.watch(dbServices);
    final _cars = Provider.of<List<Car>>(context);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return StreamBuilder(
            stream: DbServices(
              userID: userID,
              carID: _cars[index].carID,
            ).myFavoriteCar,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                _cars[index].isMyFavoriteCar = false;
                return CarFeed(car: _cars[index], userID: userID);
              } else {
                _cars[index].isMyFavoriteCar = true;
                return CarFeed(car: _cars[index], userID: userID);
              }
            },
          );
        },
        childCount: _cars.length,
      ),
    );
  }
}
