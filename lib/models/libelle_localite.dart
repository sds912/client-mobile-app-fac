import 'package:flutter/material.dart';

class LibelleLocalite {
  String libelle ;

  LibelleLocalite({
    @required this.libelle
  }) ;

  static fromJson(Map<dynamic, dynamic> l) {
    List<LibelleLocalite> liste = [] ; 
    for (var i = 0; i < l['libelles'].length; i++) {
      var item = l['libelles'][i];
      liste.add(
        LibelleLocalite(libelle: item)
      );
    }
    return liste ;
  }

  @override
  String toString() => this.libelle;

}