import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String? carID, carName, carUrlImg, carUserName, carUserID;
  Timestamp? carTimestamp;
  bool? isMyFavoriteCar;
  int? carFavoriteCount;
  Car({
    this.carID,
    this.carName,
    this.carUrlImg,
    this.carUserName,
    this.carUserID,
    this.carTimestamp,
    this.isMyFavoriteCar,
    this.carFavoriteCount,
  });
}
