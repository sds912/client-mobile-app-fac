import 'package:flutter/cupertino.dart';

class Entreprise {
  int id;
  String denomination ;
  bool selected ;
  Entreprise({
    @required this.id,
    @required this.denomination,
    @required this.selected
  });

  @override
  String toString() {
    return this.denomination;
  }
}