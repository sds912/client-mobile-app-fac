import 'package:flutter/cupertino.dart';

class Inventaire {
  int id ;
  String debut ;
  String fin;

  Inventaire({
    @required this.id,
    @required this.debut,
    @required this.fin
  });

  static Inventaire fromJson(Map<dynamic , dynamic> l ) => Inventaire(id: l['inventaire']['id'] , debut: l['inventaire']['debut'], fin: l['inventaire']['fin']) ;

  @override
  String toString() => "Inventaire du ${this.debut.split('T')[0]} au ${this.fin.split('T')[0]}";
}