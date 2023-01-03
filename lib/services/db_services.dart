import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

import '../model/carModel.dart';

class DbServices {
  CollectionReference _cars = FirebaseFirestore.instance.collection('cars');
  FirebaseStorage _storage = FirebaseStorage.instance;

  var logger = Logger();

  String? userID, carID;
  DbServices({this.userID, this.carID});

  // UPLOAD L'iMAGE VERS FIREBASE STORAGE
  Future<String> uploadFile(file) async {
    Reference reference = _storage.ref().child('cars/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  // AJOUT DE LA VOITURE DANS FIRESTORE (BDD)
  void addCar(Car car) {
    _cars
        .add({
          'carName': car.carName,
          'carUrlImg': car.carUrlImg,
          'carUserID': car.carUserID,
          'carUserName': car.carUserName,
          'carTimestamp': FieldValue.serverTimestamp(),
          'carFavoriteCount': 0,
        })
        .then((value) => logger.d("Car add successfully"))
        .onError((error, stackTrace) => logger.d("Add car error $error"));
  }

  // RECUPERER TOUTES LES VOITURES
  Stream<List<Car>> get cars {
    Query queryCars = _cars.orderBy('carTimestamp', descending: true);
    return queryCars.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Car(
          carID: doc.id,
          carName: doc.get('carName'),
          carUrlImg: doc.get('carUrlImg'),
          carUserID: doc.get('carUserID'),
          carUserName: doc.get('carUserName'),
          carFavoriteCount: doc.get('carFavoriteCount'),
          carTimestamp: doc.get('carTimestamp'),
        );
      }).toList();
    });
  }

  // AJOUT DE LA VOITURE FAVORIS DANS UNE SOUS-COLLECTION
  void addFavoriteCar(Car car, String userID) async {
    final carDocRef = _cars.doc(car.carID);
    final favoritedBy = carDocRef.collection('favoritedBy');
    int carFavoriteCount = car.carFavoriteCount!;
    int increaseCount = carFavoriteCount += 1;
    favoritedBy.doc(userID).set({
      'carName': car.carName,
      'carUrlImg': car.carUrlImg,
      'carUserID': car.carUserID,
      'carUserName': car.carUserName,
      'carTimestamp': car.carTimestamp,
      'carFavoriteCount': increaseCount,
    });
    carDocRef.update({'carFavoriteCount': increaseCount});
  }

  // RETIER LA VOITURE DANS LA LISTE DES FAVORIS
  void removeFavoriteCar(Car car, String userID) {
    final carDocRef = _cars.doc(car.carID);
    final favoritedBy = carDocRef.collection('favoritedBy');
    int carFavoriteCount = car.carFavoriteCount!;
    int decreaseCount = carFavoriteCount -= 1;
    carDocRef.update({'carFavoriteCount': decreaseCount});
    favoritedBy.doc(userID).delete();
  }

  // RECUPERATION DES VOITURES FAVORIS DE L'UTILISATEUR EN TEMPS REEL
  Stream<Car> get myFavoriteCar {
    final favoritedBy = _cars.doc(carID).collection('favoritedBy');
    return favoritedBy.doc(userID).snapshots().map((doc) {
      return Car(
        carID: doc.id,
        carName: doc.get('carName'),
        carUrlImg: doc.get('carUrlImg'),
        carUserID: doc.get('carUserID'),
        carUserName: doc.get('carUserName'),
        carFavoriteCount: doc.get('carFavoriteCount'),
        carTimestamp: doc.get('carTimestamp'),
      );
    });
  }
}
