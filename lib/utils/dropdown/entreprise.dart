import 'package:flutter/material.dart';
import 'package:v1/models/entreprise.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/text-utils.dart';

List<DropdownMenuItem<Entreprise>> buildEntreprise() {
  List<DropdownMenuItem<Entreprise>> liste = [];
  for (var item in bienvenuePageState.user.entreprisess) {
      liste.add(DropdownMenuItem(
          value: item,
          child: Center(
            child: Text(
              subStringBydii(item.denomination , 20),
              textAlign: TextAlign.center,
            ),
          )));
  }
  return liste;
}
