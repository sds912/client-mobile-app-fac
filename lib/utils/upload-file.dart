import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/models/inventaire.dart';
import 'package:v1/models/libelle_localite.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/models/users.dart';
import 'package:v1/pages/bienvenue.dart';

getFile() async {
  FilePicker.getFile().then((file) {
    if (file.path.split('.')[file.path.split('.').length - 1] == 'json') {
      Map<dynamic, dynamic> l = jsonDecode(file.readAsStringSync());
      bienvenuePageState.setState(() {
        bienvenuePageState.screenWelcome = -1;
      });
      Future.delayed(Duration(
        seconds: 1,
      )).then((value) => bienvenuePageState.setState(() {
            bienvenuePageState.setState(() {
              bienvenuePageState.inventaire = Inventaire.fromJson(l);
              bienvenuePageState.immos = Immobilisation.fromJson(l);
              bienvenuePageState.libelle_localite = LibelleLocalite.fromJson(l);
              print(bienvenuePageState.libelle_localite.length);
              bienvenuePageState.users = User.fromJson(l);
              bienvenuePageState.listeLocalites = Localites.fromJson(l);
              bienvenuePageState.screenWelcome = 2;
            });
          }));

      print(bienvenuePageState.users);
    } else {
      print('erreur survenue');
    }
  });
}
