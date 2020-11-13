import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/getUserRole.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/web.dart';
import 'package:v1/utils/writte-file.dart';
import 'package:v1/widget/showDialogError.dart';
import 'package:v1/widget/showDialogQuitorDeconect.dart';
import 'package:v1/widget/top-navBar.dart';

menuPage(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
      ),
      Positioned(
          top: -size.height * .15,
          child: Container(
            height: size.height * .5,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .22,
                ),
                Container(
                  height: size.height * .1,
                  width: size.width * .2,
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(size.height),
                      image: DecorationImage(
                          image: AssetImage('assets/images/profile_avatar.jpg'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: size.height * 0.11,
                  width: size.width * .7,
                  // color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        bienvenuePageState.user.nom,
                        style: GoogleFonts.averiaSansLibre(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                      Text(
                        getUserRole(bienvenuePageState.user),
                        style: GoogleFonts.averiaSansLibre(
                            color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/menu_background.png'),
                  fit: BoxFit.cover),
            ),
          )),
      positionedTopNavbar(size),
      Positioned(
          top: size.height * .32 + 15,
          left: size.width * .1,
          child: GestureDetector(
            onTap: () {
              bienvenuePageState.setState(() {
                bienvenuePageState.isNewImmo = false;
                // bienvenuePageState.isListDRowDown = false ;
                bienvenuePageState.screenWelcome = 3;
              });
            },
            child: Container(
              height: 100,
              width: size.width * .8,
              decoration: BoxDecoration(
                  // color: Colors.green[800],
                  image: DecorationImage(
                      image: AssetImage('assets/images/proceder_comptage.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
          )),
      Positioned(
          top: size.height * .32 + 100,
          left: size.width * .1,
          child: Container(
            height: 56.0,
            width: size.width * .8,
            child: Center(
              child: Text(
                'Procéder au comptage',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )),
      Positioned(
          top: size.height * .53,
          left: size.width * .1,
          child: GestureDetector(
            onTap: () {
              bienvenuePageState.setState(() {
                bienvenuePageState.isStartingSearch = true;
                bienvenuePageState.screenWelcome = 15;
              });
            },
            child: Container(
              height: 110,
              width: size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.orange[800],
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/liste_des_immobilisations.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
          )),
      Positioned(
          top: size.height * .53 + 105,
          left: size.width * .1,
          child: Container(
            height: 56,
            width: size.width * .35,
            child: Center(
                child: Text(
              'Immobilisations \nscannées',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )),
          )),
      Positioned(
          top: size.height * .53,
          right: size.width * .1,
          child: GestureDetector(
            onTap: () {
              getCloseComptageZone(bienvenuePageState.lastLocalite)
                  .then((verif) {
                if (verif) {
                  showDialogError(
                      context: context, msg: "Cette localité a éte clôtureé");
                } else {
                  if (bienvenuePageState.lastLocalite.id == '0') {
                    bienvenuePageState.setState(() {
                      bienvenuePageState.immo = new Immobilisation(
                          id: 0,
                          libelle: '',
                          commentaire: '',
                          description: '',
                          code: '',
                          emplacement:
                              bienvenuePageState.lastLocalite.id.toString(),
                          etat: '');
                      bienvenuePageState.isNewImmo = true;
                      bienvenuePageState.screenWelcome = 3;
                    });
                  } else {
                    bienvenuePageState.setState(() {
                      bienvenuePageState.immo = new Immobilisation(
                          id: 0,
                          libelle: '',
                          commentaire: '',
                          description: '',
                          code: '',
                          emplacement:
                              bienvenuePageState.lastLocalite.id.toString(),
                          etat: '');
                      bienvenuePageState.isNewImmo = true;

                      bienvenuePageState.shwoCardRechercheCatalogue = true;
                      bienvenuePageState.screenWelcome = 5;
                    });
                  }
                }
              });
            },
            child: Container(
              height: 110,
              width: size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.orange[800],
                  image: DecorationImage(
                      image: AssetImage('assets/images/add_immo.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
          )),
      Positioned(
          top: size.height * .53 + 105,
          right: size.width * .1,
          child: Container(
            height: 56,
            width: size.width * .35,
            child: Center(
                child: Text(
              'Nouvelle \n  immobilisation',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )),
          )),
      Positioned(
          top: size.height * .75,
          left: size.width * .1,
          child: GestureDetector(
            onTap: () {
              if (bienvenuePageState.isWeb) {
                bienvenuePageState.setState(() {
                  bienvenuePageState.screenWelcome = -1;
                });
                getImmobilisationFileJson().then((immos) async {
                  String localites = '';
                  await getAllNewLOcaliteJson()
                      .then((value) => localites = value);
                  var str =
                      '{ "inventaire" :{ "id" : ${bienvenuePageState.inventaire.id} , "immos" : [${immos}]  , "token" : "${bienvenuePageState.imei}-${bienvenuePageState.inventaire.id}"  , "localites":[$localites] ,"idCE" : "${bienvenuePageState.user.id}"  }}';
                  // print(json.encode(str));
                  // bienvenuePageState.setState(() {
                  //   bienvenuePageState.screenWelcome = 4;
                  // });
                  UtilsHttp.postByIssa('/mobile/data', str).then((value) {
                    if (value.data['code'] == 200) {
                      showDialogErrorSuccess(context: context , msg: "Envoie des données validé");
                      bienvenuePageState.setState(() {
                        bienvenuePageState.screenWelcome = 4;
                      });
                    }else {
                      showDialogError(context: context , msg: "L'envoie des données a échoué");
                    }
                  });
                });
              } else {
                getImmobilisationFileJson().then((immos) async {
                  String localites = '';
                  await getAllNewLOcaliteJson()
                      .then((value) => localites = value);
                  var str =
                      '{ "inventaire" :{ "id" : ${bienvenuePageState.inventaire.id} , "immos" : [${immos}]  , "token" : "${bienvenuePageState.imei}-${bienvenuePageState.inventaire.id}"  , "localites":[$localites] ,"idCE" : "${bienvenuePageState.user.id}"  }}';
                  setInventaireExport(str);
                  writeFileExportJson(
                      bienvenuePageState.inventaire.debut.split('T')[0]);
                });
              }
            },
            child: Container(
              height: 110,
              width: size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.orange[800],
                  image: DecorationImage(
                      image: AssetImage('assets/images/envoyer_par_mail.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
          )),
      Positioned(
          top: size.height * .75 + 95,
          left: size.width * .1,
          child: Container(
            height: 56,
            width: size.width * .35,
            child: Center(
                child: Text(
              bienvenuePageState.isWeb ? 'Envoyer' : 'Envoyer par mail',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )),
          )),
      Positioned(
          top: size.height * .75,
          right: size.width * .1,
          child: GestureDetector(
            onTap: () {
              showDialogQuitorDeconect(context);
            },
            child: Container(
              height: 110,
              width: size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.orange[800],
                  image: DecorationImage(
                      image: AssetImage('assets/images/deconection.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
          )),
      Positioned(
          top: size.height * .75 + 95,
          right: size.width * .1,
          child: Container(
            height: 56,
            width: size.width * .35,
            child: Center(
                child: Text(
              'Déconnexion',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )),
          )),
    ],
  );
}
