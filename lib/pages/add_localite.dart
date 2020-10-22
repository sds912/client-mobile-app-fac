import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/models/libelle_localite.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/add-localite-utils.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/text-utils.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/showDialogError.dart';
import 'package:v1/widget/top-navBar.dart';

addLocalite(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  // SystemChannels.textInput.invokeMethod('TextInput.hide');
  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_step_page.png'),
                fit: BoxFit.cover)),
      ),
      Positioned(
          top: size.height * .03,
          left: size.width * .2,
          child: Container(
            height: size.height * .24,
            width: size.width * .6,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo_top_bar.png'))),
          )),
      positionedTopNavbar(size),
      Positioned(
          top: size.height * .17,
          left: size.width * .1,
          child: Container(
            height: size.height * .1,
            width: size.width * .8,
            child: Center(
                child: Text(
              'Ajouter nouvelle localite',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 26,
                  fontStyle: FontStyle.normal),
            )),
          )),
      Positioned(
        top: size.height * .25,
        left: size.width * .075,
        child: Container(
          height: size.height * .45,
          width: size.width * .8,
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 16),
                  child: Container(
                    height: 50,
                    width: size.width * .6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.0,
                        ),
                        Center(
                            child: Text(
                          'Zone selectionnée : ${subStringBydii(bienvenuePageState.lastLocalite.nom, 10)}',
                          style: GoogleFonts.averiaSerifLibre(
                              fontSize: 14, fontWeight: FontWeight.w300),
                          // textAlign: TextAlign.left,
                        )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 16),
                  child: Container(
                    height: 50,
                    width: size.width * .6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.0,
                        ),
                        Center(
                            child: Container(
                          width: size.width * 0.45,
                          child: TextField(
                            showCursor: false,
                            readOnly: true,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.averiaSerifLibre(
                                fontWeight: FontWeight.w300, fontSize: 14),
                            // onChanged: (String t) {
                            //   bienvenuePageState.setState(() {
                            //     bienvenuePageState.subDivisonLocaliteAdd = t;
                            //   });
                            // },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Niveaux : '+ bienvenuePageState.lastLibelle,
                                hintStyle: GoogleFonts.averiaSerifLibre(
                                    fontSize: 14, fontWeight: FontWeight.w300)),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 16),
                  child: Container(
                    height: 50,
                    width: size.width * .6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.0,
                        ),
                        Center(
                            child: Container(
                          width: size.width * .45,
                          child: TextField(
                            showCursor: false,
                            onChanged: (String t) {
                              bienvenuePageState.setState(() {
                                bienvenuePageState.zoneLocaliteAdd = t;
                              });
                            },
                            textAlign: TextAlign.left,
                            style: GoogleFonts.averiaSerifLibre(
                                fontWeight: FontWeight.w300, fontSize: 14),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Libelle de cette zone',
                                hintStyle: GoogleFonts.averiaSerifLibre(
                                    fontSize: 14, fontWeight: FontWeight.w300)),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
          top: size.height * .81,
          left: size.width * .2,
          child: GestureDetector(
            onTap: () {
              if (bienvenuePageState.isLastLibelle) {
                if (bienvenuePageState.zoneLocaliteAdd == '' ) {
                  showDialogError(
                      context: context, msg: "Veuillez remplir les champs");
                } else {
                  bienvenuePageState.setState(() {
                    Localites ln = Localites(
                      id: '${bienvenuePageState.lastLocalite.id}-${bienvenuePageState.idLocaliteLastAdd}',
                      nom: bienvenuePageState.subDivisonLocaliteAdd,
                      niveau: bienvenuePageState.zoneLocaliteAdd,
                      idParent: '${bienvenuePageState.lastLocalite.id}',
                      subdivisions: [],
                    );
                    bienvenuePageState.listeLocaliteAdd.add(ln);
                    bienvenuePageState.lastLocalite = ln;
                    bienvenuePageState.lastLocalite.nom =
                        bienvenuePageState.zoneLocaliteAdd;
                    bienvenuePageState.lastLocalite.niveau = bienvenuePageState.lastLibelle;
                    bienvenuePageState.libelle_localite.add(LibelleLocalite(
                        libelle: bienvenuePageState.subDivisonLocaliteAdd));
                    print(bienvenuePageState.lastLocalite.toJson());
                    setNewLocalite(bienvenuePageState.lastLocalite)
                        .then((verif) {
                      setIdLocalteAdd().then((value) {
                        addLocaliteDrowdown(
                            knowNiveauaLocaliteUtils(
                                bienvenuePageState.lastLibelle),
                            bienvenuePageState.lastLocalite);
                      });
                      setLibelleLocalite(bienvenuePageState.lastLibelle)
                          .then((value) {
                        if (value) {
                          getListLibelleLocalite().then((liste) {
                            bienvenuePageState.setState(() {
                              bienvenuePageState.libelle_localite.addAll(liste);
                              List<String> libelle = [];
                              for (var it
                                  in bienvenuePageState.libelle_localite) {
                                libelle.add(it.libelle);
                              }
                              List<String> result =
                                  LinkedHashSet<String>.from(libelle).toList();
                              List<LibelleLocalite> result_et = [];

                              for (var item in result) {
                                result_et.add(
                                    bienvenuePageState.libelle_localite[
                                        bienvenuePageState.libelle_localite
                                            .lastIndexWhere((element) =>
                                                element.libelle == item)]);
                              }
                              bienvenuePageState.libelle_localite = result_et;
                            });
                            showDialogError(
                                context: context, msg: "Localite Enregistrée");
                          });
                        }
                      });
                    });
                  });
                }
              } else {
                if (bienvenuePageState.zoneLocaliteAdd == '') {
                  showDialogError(
                      context: context, msg: "Veuillez remplir votre zone");
                } else {
                  getIdLocalite()
                      .then((value) => bienvenuePageState.setState(() {
                            Localites ln = Localites(
                              id: '${bienvenuePageState.lastLocalite.id}-${value}',
                              nom: bienvenuePageState.subDivisonLocaliteAdd,
                              niveau: bienvenuePageState.lastLibelle,
                              idParent: '${bienvenuePageState.lastLocalite.id}',
                              subdivisions: [],
                            );
                            bienvenuePageState.listeLocaliteAdd.add(ln);
                            bienvenuePageState.lastLocalite = ln;
                            bienvenuePageState.lastLocalite.nom =
                                bienvenuePageState.zoneLocaliteAdd;
                            setNewLocalite(bienvenuePageState.lastLocalite);
                            setIdLocalteAdd().then((value) {
                              addLocaliteDrowdown(
                                  knowNiveauaLocaliteUtils(
                                      bienvenuePageState.lastLibelle),
                                  bienvenuePageState.lastLocalite);
                              showDialogError(
                                  context: context,
                                  msg: "Localite Enregistrée");
                            });
                          }));
                }
              }
            },
            child: Container(
              height: size.height * .07,
              width: size.width * .6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/ajouter_localite.png'))),
            ),
          )),
      Positioned(
          top: size.height * .89,
          child: Container(
            height: 5,
            width: size.width,
            color: Colors.white,
          )),
      positionedBottumNav(size, 3)
    ],
  );
}
