import 'package:fire_cars/components.dart';
import 'package:fire_cars/model/carModel.dart';
import 'package:fire_cars/services/db_services.dart';
import 'package:fire_cars/views/shared-ui/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)!.settings.arguments as Car;
    final _userID = FirebaseAuth.instance.currentUser!.uid;

    void onDeleteCar(BuildContext context, Car car) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: OpenSans(
              text: "Voulez-vous supprimer votre ${car.carName} ?",
              size: 16.0,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: OpenSans(text: "ANNULER", size: 18.0),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  DbServices().deleteCar(car.carID!);
                  showNotification(context, "Supprimer avec succès");
                },
                child: OpenSans(text: "SUPPRIMER", size: 18.0),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: OpenSans(
          text: car.carName!,
          size: 20.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          car.carUserID == _userID
              ? IconButton(
                  onPressed: () => onDeleteCar(context, car),
                  icon: Icon(Icons.delete),
                )
              : Container(),
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(image: NetworkImage(car.carUrlImg!)),
          ),
        ),
      ),
    );
  }
}
