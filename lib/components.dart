import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// OPENSANS
class OpenSans extends StatelessWidget {
  final text;
  final size;
  final color;
  final textAlignCenter;
  final fontWeight;
  const OpenSans({
    super.key,
    @required this.text,
    @required this.size,
    this.color,
    this.textAlignCenter,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      textAlign: textAlignCenter == null ? TextAlign.start : textAlignCenter,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color == null ? Colors.black : color,
        fontWeight: fontWeight == null ? FontWeight.normal : fontWeight,
      ),
    );
  }
}

// DIALOGUE BOX
DialogBox(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(35.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(width: 1.0, color: Colors.black),
      ),
      title: OpenSans(text: title.toString(), size: 20.0),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Colors.black,
          child: OpenSans(
            text: "Okay",
            size: 20.0,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

class TextForm extends StatelessWidget {
  final labelText;
  final maxLength;
  final controller;
  final validator;

  const TextForm({
    super.key,
    @required this.labelText,
    this.maxLength,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var textFormField = TextFormField(
      validator: validator,
      controller: controller,
      maxLength: maxLength == null ? null : maxLength,
      autofocus: true,
      decoration: InputDecoration(
        labelText: labelText,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        hintStyle: GoogleFonts.poppins(fontSize: 14),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5.0,
        ),
        SizedBox(child: textFormField),
      ],
    );
  }
}
