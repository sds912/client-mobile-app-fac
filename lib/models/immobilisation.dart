import 'package:flutter/material.dart';

class Immobilisation {
  int id;
  String libelle;
  String code;
  String emplacement;
  String emplacement_string ;
  String description;
  String etat;
  String commentaire;
  String status;
  String image;
  String lecteur;
  String dateTime;
  String search_list ;

  Immobilisation({
    @required this.id,
    @required this.libelle,
    @required this.commentaire,
    @required this.description,
    @required this.code,
    @required this.emplacement,
    @required this.etat,
    this.status = '1',
    this.image = '',
    this.lecteur = '',
    this.dateTime='',
    this.emplacement_string='',
    this.search_list 
  });

  static List<Immobilisation> fromJson(Map<dynamic, dynamic> l) {
    List<Immobilisation> liste = [];
    for (var item in l['immos']) {
      liste.add(Immobilisation(
          id: item['id'],
          libelle: item['libelle'],
          description: item['description'],
          code: item['code'],
          emplacement: item['emplacement'],
          commentaire: null,
          etat: null));
    }
    return liste;
  }

  @override
  String toString() =>
      "${this.id}|${this.libelle}|${this.code}|${this.description}|${this.emplacement}|${this.commentaire}|${this.etat}|${this.status}|${this.image}|${this.dateTime}|${this.emplacement_string}|${this.lecteur}|${this.search_list}";
}
