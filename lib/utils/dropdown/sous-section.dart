import 'package:flutter/material.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/text-utils.dart';

List<DropdownMenuItem<Localites>> buildSousSection(Localites ln) {
  List<DropdownMenuItem<Localites>> liste = [];
  for (var item in ln.subdivisions) {
    if (bienvenuePageState.user.localites.contains(item.id.toString()) || item.idParent !='') {
      liste.add(DropdownMenuItem(
          value: item,
          child: Center(
            child: Text(
              subStringBydii(item.nom,20),
              textAlign: TextAlign.center,
            ),
          )));
    }
  }
  return liste;
}
