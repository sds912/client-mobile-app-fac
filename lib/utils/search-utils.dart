import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';

sarchByDii(String str, List<Immobilisation> liste) {
  bienvenuePageState.setState(() {
    bienvenuePageState.isStartingSearch = false;
  });
  List<Immobilisation> new_list = [];
  for (var item in liste) {
    if (item.search_list.toLowerCase().contains(str.toLowerCase()) || item.libelle.toLowerCase().contains(str.toLowerCase()) || item.code.toLowerCase().contains(str.toLowerCase()) ) {
      new_list.add(item);
    }
  }
  bienvenuePageState.setState(() {
    bienvenuePageState.immos_scanne_menu = new_list;
  });
  // return liste.map((e) => e.search_list.toLowerCase().contains(str)).toList();
}
