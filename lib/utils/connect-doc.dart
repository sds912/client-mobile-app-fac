import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:v1/models/catalogue.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/models/inventaire.dart';
import 'package:v1/models/libelle_localite.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/models/users.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/decodeMatricule.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/web.dart';
import 'package:v1/widget/showDialogError.dart';

connectDoc(BuildContext context) async {
  bool doSothething = true;
  if (bienvenuePageState.isWeb) {
    if (bienvenuePageState.email == '' || bienvenuePageState.password == '') {
      showDialogError(context: context, msg: "Remplir tous les champs");
    } else {
      UtilsHttp.postByIssa('/login', {
        "username": bienvenuePageState.email,
        "password": bienvenuePageState.password
      }).then((value) {
        print(' value.statusCode => ${value.statusCode}');
        if (value.statusCode == 200) {
          setToken(value.data['token']).then((verif) {
            bienvenuePageState.setState(() {
              bienvenuePageState.screenWelcome = -1;
            });
            if (verif) {
              print(verif);
              UtilsHttp.getByIssa('/info').then((value) {
                var info = json.decode(value.data);
                print(info);
                bienvenuePageState.setState(() {
                  bienvenuePageState.user = User.fromJsonOne(info[0]);
                  if (bienvenuePageState.user.entreprisess.length > 1) {
                    print(bienvenuePageState.user.entreprisess);
                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = 16;
                    });
                  } else {
                    print(bienvenuePageState.user.entreprisess);
                    UtilsHttp.getByIssa(
                            '/mobile-inventaire/${bienvenuePageState.user.entreprisess.first.id}')
                        .then((value) {
                      var data = json.decode(value.data);
                      bienvenuePageState.setState(() {
                        bienvenuePageState.immos =
                            Immobilisation.fromJson(data);
                        bienvenuePageState.inventaire =
                            Inventaire.fromJson(data);
                        bienvenuePageState.catalogues = Catalogue.fromJson(data);
                        for (var item in bienvenuePageState.catalogues) {
                          bienvenuePageState.catalogue_recherche.add(item.libelle);
                        }
                      });
                    });
                    UtilsHttp.getByIssa(
                            '/mobile-locality/${bienvenuePageState.user.entreprisess.first.id}')
                        .then((value) {
                      var data = json.decode(value.data);
                      bienvenuePageState.setState(() {
                        bienvenuePageState.libelle_localite =
                            LibelleLocalite.fromJson(data);
                        bienvenuePageState.listeLocalites =
                            Localites.fromJson(data);
                        
                      });
                      for (var item in data['idOfMyLoAffectes']) {
                        bienvenuePageState.user.localites.add(item.toString());
                      }
                      bienvenuePageState.screenWelcome = 4;
                    });
                  }
                });
              });
            }
          });
        } else {
          showDialogError(
              context: context, msg: 'Email ou Mot de Passe Incorect');
        }
      }).catchError((err) {
        print(err.toString());
        if (err.toString().split('[')[2].split(']')[0] == '403') {
          showDialogError(
              context: context, msg: 'Acces bloquée veullez Le superviseur');
        } else if (err.toString().split('[')[2].split(']')[0] == '401') {
          showDialogError(
              context: context, msg: 'Email ou Mot de passe Incorect');
        } else {
          showDialogError(context: context, msg: 'unknow');
        }
      });
    }
  } else {
    if (bienvenuePageState.email == '' || bienvenuePageState.password == '') {
      showDialogError(
          context: context, msg: 'Veuillez Remplir tous les champs');
      doSothething = false;
    } else {
      bienvenuePageState.setState(() {
        bienvenuePageState.screenWelcome = -1;
      });
    }
    Future.delayed(Duration(seconds: 2))
        .then((value) => bienvenuePageState.setState(() {
              if (doSothething) {
                for (var user in bienvenuePageState.users) {
                  if (user.username == bienvenuePageState.email) {
                    if (decodeMatricule(user.password) ==
                        bienvenuePageState.password) {
                      bienvenuePageState.setState(() {
                        bienvenuePageState.connect = true;
                        bienvenuePageState.email = '';
                        bienvenuePageState.password = '';
                        bienvenuePageState.user = user;
                      });
                      setMembre(user);
                    }
                  }

                  if (bienvenuePageState.connect) {
                    getCloseInventaire().then((verif) {
                      if (verif) {
                        bienvenuePageState.setState(() {
                          bienvenuePageState.screenWelcome = 10;
                        });
                      } else {
                        bienvenuePageState.setState(() {
                          bienvenuePageState.screenWelcome = 4;
                        });
                      }
                    });
                  }
                }
              }
            }));
    Future.delayed(Duration(seconds: 4)).then((value) {
      if (bienvenuePageState.connect == false) {
        showDialogError(
            context: context, msg: 'Email ou mot de passe incorrect');
        bienvenuePageState.setState(() {
          bienvenuePageState.email = '';
          bienvenuePageState.password = '';
          bienvenuePageState.screenWelcome = 2;
        });
      }
    });
  }
}
