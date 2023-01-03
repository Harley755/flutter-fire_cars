import 'package:fire_cars/components.dart';
import 'package:fire_cars/services/db_services.dart';
import 'package:flutter/material.dart';

import '../model/carModel.dart';

class FavoriteBadge extends StatefulWidget {
  final Car? car;
  final String? userID;

  const FavoriteBadge({super.key, this.car, this.userID});

  @override
  State<FavoriteBadge> createState() => _FavoriteBadgeState();
}

class _FavoriteBadgeState extends State<FavoriteBadge> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8.0,
      right: 12.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.white.withOpacity(0.7),
        ),
        child: widget.car!.isMyFavoriteCar!
            ? GestureDetector(
                onTap: () {
                  return DbServices()
                      .removeFavoriteCar(widget.car!, widget.userID!);
                },
                child: Row(
                  children: [
                    OpenSans(
                      text: '${widget.car!.carFavoriteCount}',
                      size: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  return DbServices()
                      .addFavoriteCar(widget.car!, widget.userID!);
                },
                child: Row(
                  children: [
                    widget.car!.carFavoriteCount! > 0
                        ? OpenSans(
                            text: '${widget.car!.carFavoriteCount}',
                            size: 15.0,
                            fontWeight: FontWeight.bold,
                          )
                        : Container(),
                    Icon(
                      Icons.favorite,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
