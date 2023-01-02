import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../model/carModel.dart';

final authService =
    ChangeNotifierProvider.autoDispose<DbServices>((ref) => DbServices());

class DbServices extends ChangeNotifier {
  CollectionReference _cars = FirebaseFirestore.instance.collection('cars');
  FirebaseStorage _storage = FirebaseStorage.instance;

  var logger = Logger();

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
  Future<List<Iterable<Car>>> get cars {
    Query queryCars = _cars.orderBy('carTimestamp', descending: true);
    return queryCars.snapshots().map((snapshot) {
      return snapshot.docs.map(
        (doc) => Car(
          carID: doc.id,
          carName: doc.get('carName'),
          carUrlImg: doc.get('carUrlImg'),
          carUserID: doc.get('carUserID'),
          carUserName: doc.get('carUserName'),
          carTimestamp: doc.get('carTimestamp'),
          carFavoriteCount: doc.get('carFavoriteCount'),
        ),
      );
    }).toList();
  }
}
