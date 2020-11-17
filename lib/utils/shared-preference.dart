import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1/models/entreprise.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/models/inventaire.dart';
import 'package:v1/models/libelle_localite.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/models/users.dart';
import 'package:v1/pages/bienvenue.dart';

getInventaireFile() => SharedPreferences.getInstance().then((prefs) {
      String inventaire = prefs.getString('inventaires');
      Map<dynamic, dynamic> l = jsonDecode(inventaire);
      bienvenuePageState.setState(() {
        bienvenuePageState.inventaire = Inventaire.fromJson(l);
        bienvenuePageState.immos = Immobilisation.fromJson(l);
        bienvenuePageState.libelle_localite = LibelleLocalite.fromJson(l);
        bienvenuePageState.users = User.fromJson(l);
        bienvenuePageState.listeLocalites = Localites.fromJson(l);
        bienvenuePageState.screenWelcome = 2;
      });
    });

Future<bool> verifInventaireExist() => SharedPreferences.getInstance()
    .then((prefs) => prefs.getString('inventaire') == null ? false : true);

setIventaireFile(File file) async => SharedPreferences.getInstance()
    .then((prefs) => prefs.setString('inventaire', file.readAsStringSync()));

Future<String> getWelcomeMessage() async => SharedPreferences.getInstance()
    .then((prefs) => prefs.getString("welcomemessage"));

Future setWelcomeMessage() async => SharedPreferences.getInstance()
    .then((prefs) => prefs.setString('welcomemessage', "1"));

setMembre(User user) async => SharedPreferences.getInstance()
    .then((prefs) => prefs.setString('userconnect', user.toString()));

Future<User> getUserConnect() async =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('userconnect') != null) {
        var lastConnect = prefs.getString('userconnect').split('chez_joe');
        List<String> rls = [];
        for (var item in lastConnect[4].split('150495')) {
          rls.add(item);
        }

        List<Entreprise> ent = [];

        for (var item in lastConnect[5].split('150495')) {
          ent.add(Entreprise(
              id: int.parse(item.split('asma')[0]),
              denomination: item.split('asma')[1],
              selected: false));
        }

        List<String> idOL = [];

        for (var item in lastConnect[6].split('150495')) {
          idOL.add(item);
        }

        return User(
            id: int.parse(lastConnect[0]),
            username: lastConnect[2],
            password: lastConnect[3],
            roles: rls,
            status: '',
            nom: lastConnect[1],
            localites: idOL,
            entreprisess: ent);
      }
    });

setImmobilisationListFile(Immobilisation immo) async =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('immobilisations') == null) {
        prefs.setString('immobilisations', immo.toString());
      } else {
        String new_listImmo = prefs.getString('immobilisations') +
            '#' +
            bienvenuePageState.immo.toString();
        prefs.setString('immobilisations', new_listImmo);
      }
    });

setImmobilisationListFileJson(Immobilisation immo) async =>
    SharedPreferences.getInstance().then((prefs) {
      var im = '';
      if (immo.image == '') {
        im = '';
      } else {
        im = 'data:image/jpeg;base64,${immo.image}';
      }
      var str =
          '{"id" : ${immo.id}  , "libelle" : "${immo.libelle}" , "code" : "${immo.code}" , "emplacement" :"${immo.emplacement}" , "description":"${immo.description}", "etat" : "${immo.etat}" , "image" : "$im", "status" : ${immo.status} , "lecteur" : ${bienvenuePageState.user.id} , "date" : "${DateTime.now()}" }';
      if (prefs.getString('immobilisationsJson') == null) {
        prefs.setString('immobilisationsJson', str);
      } else {
        String new_listImmoJson =
            prefs.getString('immobilisationsJson') + ',' + str;
        prefs.setString('immobilisationsJson', new_listImmoJson);
      }
    });
setInventaireExport(String value) async =>
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('inventaireExport', value);
    });

setListImmobilisationFileJson(List<Immobilisation> immos) async {
  SharedPreferences.getInstance().then((prefs) {
    prefs.remove('immobilisationsJson');
    for (var immo in immos) {
      var im = '';
      if (immo.image == '') {
        im = '';
      } else {
        im = 'data:image/jpeg;base64,${immo.image}';
      }
      var str =
          '{"id" : ${immo.id}  , "libelle" : "${immo.libelle}" , "code" : "${immo.code}" , "emplacement" :"${immo.emplacement}" , "description":"${immo.description}", "etat" : "${immo.etat}" , "image" : "$im", "status" : ${immo.status} , "lecteur" : ${bienvenuePageState.user.id} , "date" : "${DateTime.now()}" }';
      if (prefs.getString('immobilisationsJson') == null) {
        prefs.setString('immobilisationsJson', str);
      } else {
        String new_listImmoJson =
            prefs.getString('immobilisationsJson') + ',' + str;
        prefs.setString('immobilisationsJson', new_listImmoJson);
      }
    }
  });
}

Future getImmobilisationFileJson() async =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('immobilisationsJson') == null) return "";
      return prefs.getString('immobilisationsJson');
    });

Future<List<Immobilisation>> getImmobilisationListFile() {
  List<Immobilisation> liste = [];
  return SharedPreferences.getInstance().then((prefs) {
    if (prefs.getString('immobilisations') == null) {
      return [];
    } else {
      var immoTab = prefs.getString('immobilisations').split('#');

      for (var immo in immoTab) {
        var p = immo.split('|');
        liste.add(Immobilisation(
            id: int.parse(p[0]),
            code: p[2],
            dateTime: p[9],
            commentaire: p[5],
            description: p[3],
            emplacement: p[4],
            etat: p[6],
            libelle: p[1],
            status: p[7],
            image: p[8],
            lecteur: p[11],
            search_list: p[12],
            emplacement_string: p[10]));
      }
      return liste;
    }
  });
}

Future<bool> verifIfImmoHereInSharedPreference(Immobilisation immo) async {
  return SharedPreferences.getInstance().then((prefs) {
    if (prefs.getString('immobilisations') == null) {
      return false;
    } else {
      var jD = prefs.getString('immobilisations').split('#');
      bool isHere = false;
      for (var item in jD) {
        print(item.split('|'));
        var p = item.split('|');
        if (p[2] == immo.code) {
          isHere = true;
        }
      }
      return isHere;
    }
  });
}

Future<bool> setCloseComptageZone(Localites ln) =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('closeZone') == null) {
        return prefs.setString('closeZone', '1|${ln.id}');
      } else {
        var new_string = prefs.getString('closeZone') + '#' + '1|${ln.id}';

        return prefs.setString('closeZone', new_string);
      }
    });
Future<bool> rebuildSetCloseComptageZone(Localites ln) =>
    SharedPreferences.getInstance().then((prefs) {
      String new_string = '';
      if (prefs.getString('closeZone') == null) {
        return prefs.setString('closeZone', '0|${ln.id}');
      } else {
        var Jd = prefs.getString('closeZone').split('#');
        for (var item in Jd) {
          var cls = item.split('|');
          Localites l = Localites(id: cls[1], nom: '', subdivisions: []);
          if (cls[0] == '1' && cls[1] == ln.id.toString()) {
            new_string += prefs.getString('closeZone') + '#' + '0|${l.id}';
          } else {
            new_string += prefs.getString('closeZone') + '#' + '1|${l.id}';
          }
          print(new_string);
        }
        // print('new_string => $new_string');
        return prefs.setString('closeZone', new_string);
      }
    });

Future<bool> setCodeOpenLocalite(String str) =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('setCodeOpenLocalite') == null) {
        return prefs.setString('setCodeOpenLocalite', str);
      } else {
        return prefs.setString('setCodeOpenLocalite',
            prefs.getString('setCodeOpenLocalite') + "#wicf_lilz_Ike" + str);
      }
    });

Future<bool> checkIfCodeExist(String str) =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('setCodeOpenLocalite') == null) {
        return false;
      } else {
        var JD = prefs.getString('setCodeOpenLocalite').split('#wicf_lilz_Ike');

        for (var item in JD) {
          if (item == str) {
            return true;
          }
        }
        return false;
      }
    });

Future<bool> getCloseComptageZone(Localites ln) =>
    SharedPreferences.getInstance().then((prefs) {
      bool verif = false;
      if (prefs.getString('closeZone') == null) {
        return false;
      } else {
        var Jd = prefs.getString('closeZone').split('#');
        for (var item in Jd) {
          var cls = item.split('|');
          if (cls[0] == '1' && cls[1] == ln.id.toString()) {
            verif = true;
          }
        }
        if (verif) {
          for (var item in Jd) {
            var cls = item.split('|');
            if (cls[0] == '0' && cls[1] == ln.id.toString()) {
              verif = false;
            }
          }
        }
        return verif;
      }
    });

Future<bool> setCloseInventaire(String inc_code) =>
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('closeInventaire', inc_code));

Future<bool> getCloseInventaire() =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('closeInventaire') == null)
        return false;
      else if (prefs.getString('closeInventaire') == '1') return true;
      return false;
    });

Future<bool> removeIsClose() => SharedPreferences.getInstance().then((prefs) {
      prefs.remove('closeInventaire');
    });

Future<bool> setToken(String token) async => SharedPreferences.getInstance()
    .then((prefs) => prefs.setString('token', token));

getToken() async =>
    SharedPreferences.getInstance().then((prefs) => prefs.getString('token'));

Future<bool> setNewLocalite(Localites ln) async =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('newLocalite') == null) {
        return prefs.setString('newLocalite', ln.toJson());
      } else {
        String new_localite =
            prefs.getString('newLocalite') + 'chez_joe' + ln.toJson();
        return prefs.setString('newLocalite', new_localite);
      }
    });

Future<List<Localites>> getAllNewLocalite() =>
    SharedPreferences.getInstance().then((prefs) {
      List<Localites> ln = [];
      if (prefs.getString('newLocalite') == null) {
        return [];
      } else {
        var Jd = prefs.getString('newLocalite').split('chez_joe');
        for (var item in Jd) {
          ln.add(Localites(
              subdivisions: [],
              niveau: json.decode(item)["niveau"],
              idParent: json.decode(item)["idParent"],
              id: json.decode(item)['id'],
              nom: json.decode(item)["nom"]));
        }
        return ln;
      }
    });

Future<String> getAllNewLOcaliteJson() =>
    SharedPreferences.getInstance().then((value) async {
      String str = '';
      await getAllNewLocalite().then((liste) {
        for (var i = 0; i < liste.length; i++) {
          var item = liste[i];
          if (i == 0) {
            str = str + item.toJson();
          } else {
            str = str + ',' + item.toJson();
          }
        }
      });
      return str;
    });

getIntNiveau(String str) {
  for (var i = 0; i < bienvenuePageState.libelle_localite.length; i++) {
    var item = bienvenuePageState.libelle_localite[i];
    if (item.libelle == str) return i;
  }
  return 0;
}

Future<List<Localites>> getSubdivisionLocalite(
        Localites ln, List<Localites> liste) =>
    SharedPreferences.getInstance().then((prefs) {
      List<Localites> lis = [];
      for (var j in liste) {
        if (ln.id == j.idParent) {
          lis.add(Localites(
              subdivisions: j.subdivisions,
              niveau: j.niveau,
              idParent: j.idParent,
              id: j.id,
              nom: j.nom));
        }
      }
      ln.subdivisions.addAll(lis);
      print(ln.subdivisions);
      List<String> id = [];
      for (var it in ln.subdivisions) {
        id.add(it.id);
      }
      List<String> result = LinkedHashSet<String>.from(id).toList();

      List<Localites> result_et = [];

      for (var item in result) {
        result_et.add(ln.subdivisions[
            ln.subdivisions.lastIndexWhere((element) => element.id == item)]);
      }

      return result_et;
    });

Future<bool> setIdLocalteAdd() async =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('idLastLocalite') == null) {
        return prefs.setString('idLastLocalite', '2');
      } else {
        int new_id = int.parse(prefs.getString('idLastLocalite')) + 1;
        return prefs.setString('idLastLocalite', new_id.toString());
      }
    });
Future<String> getIdLocalite() async =>
    SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('idLastLocalite') == null
          ? '1'
          : prefs.getString('idLastLocalite');
    });

Future<bool> setLibelleLocalite(String str) => SharedPreferences.getInstance()
    .then((prefs) => prefs.getString('libelleLocalites') == null
        ? prefs.setString('libelleLocalites', str)
        : prefs.setString('libelleLocalites',
            prefs.getString('libelleLocalites') + 'asmaLibelleLocalite' + str));

Future<List<LibelleLocalite>> getListLibelleLocalite() =>
    SharedPreferences.getInstance().then((prefs) {
      List<LibelleLocalite> liste = [];
      if (prefs.getString('libelleLocalites') == null) {
        return liste;
      } else {
        var jd =
            prefs.getString('libelleLocalites').split('asmaLibelleLocalite');
        for (var item in jd) {
          liste.add(LibelleLocalite(libelle: item));
        }
        return liste;
      }
    });

Future<List> getListIdClose() async =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('idListIdClose') == null) {
        return [];
      } else {
        String DJ = prefs.getString('idListIdClose');
        List<String> listIdClose = DJ.split('#deep_dose');
        return listIdClose;
      }
    });

setListIdClose(String id) async =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('idListIdClose') == null) {
        prefs.setString('idListIdClose', id);
      } else {
        prefs.setString(
            'idListClose', prefs.getString('idListClose') + '#deep_dose' + id);
      }
    });

setListIdRunning(String id) => SharedPreferences.getInstance().then((prefs) {
      print('setListIdRunning => $id');
      if (prefs.getString('idListIdRunning') == null) {
        prefs.setString('idListIdRunning', id);
      } else {
        String str = prefs.getString('idListIdRunning') + '#deep_dose' + id;
        prefs.setString('idListIdRunning', str);
      }
    });

Future<List> getListIdRunning() async =>
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('idListIdRunning') == null) {
        return [];
      } else {
        String DJ = prefs.getString('idListIdRunning');
        List<String> listIdClose = DJ.split('#deep_dose');
        print(listIdClose);
        return listIdClose;
      }
    });

Future<String> getListIdRunningString() async =>
    SharedPreferences.getInstance().then((value) {
      String str = '';
      getListIdRunning().then((liste) {
        for (var i = 0; i < liste.length; i++) {
          if (i == 0) {
            str = liste[i];
          } else {
            str = str + ',' + liste[i];
          }
        }
        print('getListIdRunningString => $str');
        return str;
      });
    });
