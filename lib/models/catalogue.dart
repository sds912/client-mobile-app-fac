import 'package:flutter/widgets.dart';

class Catalogue {
  String libelle;
  String marque;
  String reference;
  String specifites;
  String fournisseur;

  Catalogue(
      {@required this.libelle,
      this.marque = '',
      this.fournisseur = '',
      this.reference = '',
      this.specifites = ''});

  static fromJson(Map<dynamic, dynamic> l) {
    List<Catalogue> liste = [];
    for (var item in l['catalogues']) {
      liste.add(Catalogue(
          libelle: item['libelle'],
          marque: item['marque'],
          fournisseur: item['fournisseur'],
          specifites: item['specifites']));
    }

    return liste;
  }
}
