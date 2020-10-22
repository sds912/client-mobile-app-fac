import 'package:v1/models/libelle_localite.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/pages/bienvenue.dart';

int knowNiveauaLocaliteUtils(String str) {
  for (var i = 0; i < bienvenuePageState.libelle_localite.length; i++) {
    var item = bienvenuePageState.libelle_localite[i];
    if (item.libelle == str) {
      return i;
    }
  }
  return bienvenuePageState.libelle_localite.length + 1;
}

addLocaliteDrowdown(int i, Localites ln) {
  switch (i) {
    case 1:
      print('addLocaliteDrowdown 1');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauZeroLocalite.subdivisions.add(ln);
        bienvenuePageState.libelle_localite
            .add(LibelleLocalite(libelle: bienvenuePageState.lastLibelle));
        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    case 1:
      print('addLocaliteDrowdown 2');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauUnLocalite.subdivisions.add(ln);
        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    case 2:
      print('addLocaliteDrowdown 3');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauDeuxLocalite.subdivisions.add(ln);
        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    case 3:
      print('addLocaliteDrowdown 3');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauTroisLocalite.subdivisions.add(ln);
        bienvenuePageState.libelle_localite
            .add(LibelleLocalite(libelle: bienvenuePageState.lastLibelle));

        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    case 4:
      print('addLocaliteDrowdown 4');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauCinqLocalite.subdivisions.add(ln);
        bienvenuePageState.libelle_localite
            .add(LibelleLocalite(libelle: bienvenuePageState.lastLibelle));

        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    case 5:
      print('addLocaliteDrowdown 5');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauSixLocalite.subdivisions.add(ln);
        bienvenuePageState.libelle_localite
            .add(LibelleLocalite(libelle: bienvenuePageState.lastLibelle));

        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    case 6:
      print('addLocaliteDrowdown 6');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauSeptLocalite.subdivisions.add(ln);
        bienvenuePageState.libelle_localite
            .add(LibelleLocalite(libelle: bienvenuePageState.lastLibelle));

        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    case 7:
      print('addLocaliteDrowdown 7');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauHUitLocalite.subdivisions.add(ln);
        bienvenuePageState.libelle_localite
            .add(LibelleLocalite(libelle: bienvenuePageState.lastLibelle));

        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    case 8:
      print('addLocaliteDrowdown 8');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauNeufLocalite.subdivisions.add(ln);
        bienvenuePageState.libelle_localite
            .add(LibelleLocalite(libelle: bienvenuePageState.lastLibelle));

        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    case 9:
      print('addLocaliteDrowdown 9');
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauDixLocalite.subdivisions.add(ln);
        bienvenuePageState.libelle_localite
            .add(LibelleLocalite(libelle: bienvenuePageState.lastLibelle));

        bienvenuePageState.screenWelcome = 3;
        bienvenuePageState.isTailleLibDiff = true;
      });
      break;
    default:
  }
}
