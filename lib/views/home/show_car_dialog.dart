import 'dart:io';

import 'package:fire_cars/services/db_services.dart';
import 'package:fire_cars/shared-ui/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components.dart';
import '../../model/carModel.dart';

class CarDialog {
  User? user;
  CarDialog({this.user});

  // SHOW DIALOG CARD
  void ShowCardDialog(
      BuildContext context, ImageSource source, User? user) async {
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);

    final formKey = GlobalKey<FormState>();

    TextEditingController _carName = TextEditingController();

    void onSubmit(context, keyForm, file, carName, user) async {
      if (keyForm.currentState!.validate()) {
        Navigator.of(context).pop();
        showNotification(context, "Chargement...");
        DbServices db = DbServices();
        String _carUrlImg = await db.uploadFile(file);
        db.addCar(Car(
          carName: carName.text,
          carUrlImg: _carUrlImg,
          carUserID: user!.uid,
          carUserName: user!.displayName,
        ));
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.grey,
                image: DecorationImage(
                  image: FileImage(_file),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: TextForm(
                      labelText: "Nom de la voiture *",
                      maxLength: 20,
                      controller: _carName,
                      validator: (text) {
                        if (text.toString().isEmpty) {
                          return "Ce champ est obligatoire";
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: OpenSans(text: "ANNULER", size: 16.0),
                        ),
                        SizedBox(width: 5.0),
                        ElevatedButton(
                          onPressed: () {
                            return onSubmit(
                              context,
                              formKey,
                              _file,
                              _carName,
                              user,
                            );
                          },
                          child: OpenSans(text: "PUBLIER", size: 16.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
