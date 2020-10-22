import 'package:flutter/widgets.dart';

class Localites {
  String id;
  String nom;
  List<Localites> subdivisions;
  String idParent ; 
  String niveau ;

  Localites(
      {@required this.id, @required this.nom, @required this.subdivisions , this.idParent='' , this.niveau=''});

  static List<Localites> fromJson(Map<dynamic, dynamic> l) {
    List<Localites> localites = [];
    for (var item in l['localites']) {
      localites.add(Localites(
          id: item['id'].toString(),
          nom: item['nom'],
          subdivisions: chargeAllLocalite(item)));
    }
    return localites;
  }

  addSubdivision(Localites localite) {
    this.subdivisions.add(localite);
  }

  String toJson() => '{"id" : "${this.id}" , "nom" : "${this.nom}" ,"niveau" : "${this.niveau}" , "idParent":"${this.idParent}"}';

  @override
  String toString() => "${this.nom}";
}

List<Localites> chargeAllLocalite(Map<dynamic, dynamic> l) {
  List<Localites> localites = [];
  if (l['subdivisions'].length == 0) {
    localites.add(Localites(id: l['id'].toString(), nom: l['nom'], subdivisions: []));
    return localites;
  } else {
    for (var item in l['subdivisions']) {
      if (item['subdivisions'].length > 0) {
        localites.add(
          Localites(
              id: item['id'].toString(),
              nom: item['nom'],
              subdivisions: chargeAllLocalite(item)),
        );
      } else {
        localites
            .add(Localites(id: item['id'].toString(), nom: item['nom'], subdivisions: []));
      }
    }
    return localites;
  }
}
