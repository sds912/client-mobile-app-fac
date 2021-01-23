import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/colors.dart';
import 'package:v1/utils/dropdown/section.dart';
import 'package:v1/utils/dropdown/sous-section.dart';
import 'package:v1/utils/reset-step.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/text-utils.dart';

step(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  bienvenuePageState.setState(() {
    bienvenuePageState.niveauZero = buildSection();
  });
  return bienvenuePageState.libelle_localite.isEmpty ? Container(child: Text('Pas de localités', style: TextStyle(color: Colors.white),)):
  
  ListView(
    padding: EdgeInsets.all(8.0),
    physics: BouncingScrollPhysics(),
    
    children: [
      // Continent
      Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 16),
        child: Container(
          height: 50,
          width: size.width * .6,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              SizedBox(
                width: size.width * .05,
              ),
              Container(
                width: size.width * 0.635,
                child: DropdownButton(
                  
                  isExpanded: true,
                  items: bienvenuePageState.niveauZero,
                  dropdownColor: quatriemeColor,
                  autofocus: true,
                  itemHeight: 50,
                  
                  focusColor: Colors.red,
                  style: GoogleFonts.averiaSansLibre(
                      fontSize: 14,
                      color: troisiemeColor,
                      
                      fontWeight: FontWeight.w400),
                  onChanged: (t) async {
                    await getAllNewLocalite().then((liste) async {
                      await getSubdivisionLocalite(t, liste).then((value) {
                        bienvenuePageState.setState(() {
                          bienvenuePageState.niveauZeroLocalite.subdivisions =
                              value;
                        });
                      });
                    });

                    bienvenuePageState.setState(() {
                      bienvenuePageState.taille_libelle = 1;
                      bienvenuePageState.niveauZeroLocalite.nom = t.nom;
                      bienvenuePageState.search_immo =
                          bienvenuePageState.niveauZeroLocalite.nom;
                      bienvenuePageState.niveauZeroLocalite.id = t.id;
                      bienvenuePageState.niveauZeroLocalite.idParent =
                          t.idParent;
                      bienvenuePageState.lastLibelle =
                          bienvenuePageState.libelle_localite.length == 1
                              ? bienvenuePageState
                                  .libelle_localite[bienvenuePageState
                                          .libelle_localite.length -
                                      1]
                                  .libelle
                              : bienvenuePageState.libelle_localite[1].libelle;
                      bienvenuePageState.lastLocalite = t;
                      bienvenuePageState.lastLocalite.niveau =
                          bienvenuePageState.lastLibelle;
                      bienvenuePageState.isLastLibelle =
                          bienvenuePageState.libelle_localite.length ==
                              bienvenuePageState.taille_libelle;
                      print(bienvenuePageState.lastLocalite);
                    });
                    bienvenuePageState.setState(() {
                      resetStateStep0();

                      bienvenuePageState.niveauUn = buildSousSection(
                          bienvenuePageState.niveauZeroLocalite);
                    });
                  },
                  underline: Container(),
                  icon:Icon(
                Icons.arrow_drop_down_outlined,
                size: 28,
              ),
                  hint: bienvenuePageState.niveauZeroLocalite.nom == ''
                      ? Text(subStringBydii(
                          bienvenuePageState.libelle_localite[0].libelle, 20))
                      : Text(subStringBydii(
                          bienvenuePageState.niveauZeroLocalite.nom, 20)),
                
                ),
              )
            ],
          ),
        ),
      ),
      // Pays
      bienvenuePageState.niveauZeroLocalite.subdivisions.length > 0
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: 50,
                width: size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Container(
                      width: size.width * 0.635,
                      child: DropdownButton(
                        items: bienvenuePageState.niveauUn,
                        dropdownColor: quatriemeColor,
                        autofocus: true,
                        isExpanded: true,
                        itemHeight: 50,
                        focusColor: Colors.red,
                        style: GoogleFonts.averiaSansLibre(
                            fontSize: 14,
                            color: troisiemeColor,
                            fontWeight: FontWeight.w400),
                        onChanged: (t) async {
                          await getAllNewLocalite().then((liste) async {
                            await getSubdivisionLocalite(t, liste)
                                .then((value) {
                              print(value);
                              bienvenuePageState.setState(() {
                                bienvenuePageState
                                    .niveauUnLocalite.subdivisions = value;
                              });
                            });
                          });
                          bienvenuePageState.setState(() {
                            bienvenuePageState.taille_libelle = 2;

                            bienvenuePageState.niveauUnLocalite.nom = t.nom;
                            bienvenuePageState.search_immo =
                                bienvenuePageState.niveauZeroLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauUnLocalite.nom;
                            bienvenuePageState.niveauUnLocalite.id = t.id;
                            bienvenuePageState.niveauUnLocalite.idParent =
                                t.idParent;
                            bienvenuePageState.lastLibelle =
                                bienvenuePageState.libelle_localite.length == 2
                                    ? bienvenuePageState
                                        .libelle_localite[bienvenuePageState
                                                .libelle_localite.length -
                                            1]
                                        .libelle
                                    : bienvenuePageState
                                        .libelle_localite[0].libelle;
                            bienvenuePageState.lastLocalite = t;
                            bienvenuePageState.lastLocalite.niveau =
                                bienvenuePageState.lastLibelle;
                            bienvenuePageState.isLastLibelle =
                                bienvenuePageState.libelle_localite.length ==
                                    bienvenuePageState.taille_libelle;
                          });
                          bienvenuePageState.setState(() {
                            resetStateStep1();
                            bienvenuePageState.niveauDeux = buildSousSection(
                                bienvenuePageState.niveauUnLocalite);
                          });
                        },
                        underline: Container(),
                        icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                    ),
                        hint: bienvenuePageState.niveauUnLocalite.nom == ''
                            ? Text(subStringBydii(
                                bienvenuePageState.libelle_localite[1].libelle,
                                20))
                            : Text(subStringBydii(
                                bienvenuePageState.niveauUnLocalite.nom, 20)),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(),
      // Regions
      bienvenuePageState.niveauUnLocalite.subdivisions.length > 0
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: 50,
                width: size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Container(
                      width: size.width * 0.635,
                      child: DropdownButton(
                        items: bienvenuePageState.niveauDeux,
                        dropdownColor: quatriemeColor,
                        autofocus: true,
                        isExpanded: true,
                        itemHeight: 50,
                        focusColor: Colors.red,
                        style: GoogleFonts.averiaSansLibre(
                            fontSize: 14,
                            color: troisiemeColor,
                            fontWeight: FontWeight.w400),
                        onChanged: (t) async {
                          await getAllNewLocalite().then((liste) async {
                            await getSubdivisionLocalite(t, liste)
                                .then((value) {
                              print(value);
                              bienvenuePageState.setState(() {
                                bienvenuePageState
                                    .niveauDeuxLocalite.subdivisions = value;
                              });
                            });
                          });
                          bienvenuePageState.setState(() {
                            bienvenuePageState.taille_libelle = 3;

                            bienvenuePageState.niveauDeuxLocalite.nom = t.nom;
                            bienvenuePageState.search_immo =
                                bienvenuePageState.niveauZeroLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauUnLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauDeuxLocalite.nom;
                            bienvenuePageState.niveauDeuxLocalite.id = t.id;
                            bienvenuePageState.niveauDeuxLocalite.idParent =
                                t.idParent;
                            bienvenuePageState.lastLibelle =
                                bienvenuePageState.libelle_localite.length == 3
                                    ? bienvenuePageState
                                        .libelle_localite[bienvenuePageState
                                                .libelle_localite.length -
                                            1]
                                        .libelle
                                    : bienvenuePageState
                                        .libelle_localite[3].libelle;
                            bienvenuePageState.lastLocalite = t;
                            bienvenuePageState.lastLocalite.niveau =
                                bienvenuePageState.lastLibelle;

                            bienvenuePageState.isLastLibelle =
                                bienvenuePageState.libelle_localite.length ==
                                    bienvenuePageState.taille_libelle;
                          });
                          bienvenuePageState.setState(() {
                            resetStateStep2();
                            bienvenuePageState.niveauTrois = buildSousSection(
                                bienvenuePageState.niveauDeuxLocalite);
                          });
                        },
                        underline: Container(),
                        icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                    ),
                        hint: bienvenuePageState.niveauDeuxLocalite.nom == ''
                            ? Text(subStringBydii(
                                bienvenuePageState.libelle_localite[2].libelle,
                                20))
                            : Text(subStringBydii(
                                bienvenuePageState.niveauDeuxLocalite.nom, 20)),
                      ),
                    )
                    
                  ],
                ),
              ),
            )
          : Container(),
      // Agences
      bienvenuePageState.niveauDeuxLocalite.subdivisions.length > 0
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: 50,
                width: size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Container(
                      width: size.width * 0.635,
                      child: DropdownButton(
                        items: bienvenuePageState.niveauTrois,
                        dropdownColor: quatriemeColor,
                        autofocus: true,
                        isExpanded: true,
                        itemHeight: 50,
                        focusColor: Colors.red,
                        style: GoogleFonts.averiaSansLibre(
                            fontSize: 14,
                            color: troisiemeColor,
                            fontWeight: FontWeight.w400),
                        onChanged: (t) async {
                          await getAllNewLocalite().then((liste) async {
                            await getSubdivisionLocalite(t, liste)
                                .then((value) {
                              print(value);
                              bienvenuePageState.setState(() {
                                bienvenuePageState
                                    .niveauTroisLocalite.subdivisions = value;
                              });
                            });
                          });
                          bienvenuePageState.setState(() {
                            bienvenuePageState.taille_libelle = 4;
                            bienvenuePageState.niveauTroisLocalite.nom = t.nom;
                            bienvenuePageState.search_immo =
                                bienvenuePageState.niveauZeroLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauUnLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauDeuxLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauTroisLocalite.nom;
                            bienvenuePageState.niveauTroisLocalite.id = t.id;
                            bienvenuePageState.niveauTroisLocalite.idParent =
                                t.idParent;
                            bienvenuePageState.lastLibelle =
                                bienvenuePageState.libelle_localite.length == 4
                                    ? bienvenuePageState
                                        .libelle_localite[bienvenuePageState
                                                .libelle_localite.length -
                                            1]
                                        .libelle
                                    : bienvenuePageState
                                        .libelle_localite[4].libelle;
                            bienvenuePageState.lastLocalite = t;
                            bienvenuePageState.lastLocalite.niveau =
                                bienvenuePageState.lastLibelle;

                            bienvenuePageState.isLastLibelle =
                                bienvenuePageState.libelle_localite.length ==
                                    bienvenuePageState.taille_libelle;
                          });
                          bienvenuePageState.setState(() {
                            resetStateStep4();
                            bienvenuePageState.niveauQuatre = buildSousSection(
                                bienvenuePageState.niveauTroisLocalite);
                          });
                        },
                        underline: Container(),
                        icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                    ),
                        hint: bienvenuePageState.niveauTroisLocalite.nom == ''
                            ? Text(subStringBydii(
                                bienvenuePageState.libelle_localite[3].libelle,
                                20))
                            : Text(subStringBydii(
                                bienvenuePageState.niveauTroisLocalite.nom,
                                20)),
                      ),
                    )
                    
                  ],
                ),
              ),
            )
          : Container(),
      // Niveaux
      bienvenuePageState.niveauTroisLocalite.subdivisions.length > 0
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: 50,
                width: size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Container(
                      width: size.width * 0.635,
                      child: DropdownButton(
                        items: bienvenuePageState.niveauQuatre,
                        dropdownColor: quatriemeColor,
                        autofocus: true,
                        isExpanded: true,
                        itemHeight: 50,
                        focusColor: Colors.red,
                        style: GoogleFonts.averiaSansLibre(
                            fontSize: 14,
                            color: troisiemeColor,
                            fontWeight: FontWeight.w400),
                        onChanged: (t) async {
                          await getAllNewLocalite().then((liste) async {
                            await getSubdivisionLocalite(t, liste)
                                .then((value) {
                              bienvenuePageState.setState(() {
                                bienvenuePageState
                                    .niveauQuatreLocalite.subdivisions = value;
                              });
                            });
                          });
                          bienvenuePageState.setState(() {
                            bienvenuePageState.taille_libelle = 5;
                            bienvenuePageState.niveauQuatreLocalite.nom = t.nom;
                            bienvenuePageState.search_immo =
                                bienvenuePageState.niveauZeroLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauUnLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauDeuxLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauTroisLocalite.nom +
                                    '*' +
                                    bienvenuePageState.niveauQuatreLocalite.nom;
                            bienvenuePageState.niveauQuatreLocalite.id = t.id;
                            bienvenuePageState.niveauQuatreLocalite.idParent =
                                t.idParent;
                            bienvenuePageState.lastLibelle =
                                bienvenuePageState.libelle_localite.length == 5
                                    ? bienvenuePageState
                                        .libelle_localite[bienvenuePageState
                                                .libelle_localite.length -
                                            1]
                                        .libelle
                                    : bienvenuePageState
                                        .libelle_localite[5].libelle;
                            bienvenuePageState.lastLocalite = t;
                            bienvenuePageState.lastLocalite.niveau =
                                bienvenuePageState.lastLibelle;

                            bienvenuePageState.isLastLibelle =
                                bienvenuePageState.libelle_localite.length ==
                                    bienvenuePageState.taille_libelle;
                          });
                          bienvenuePageState.setState(() {
                            resetStateStep5();
                            bienvenuePageState.niveauCinq = buildSousSection(
                                bienvenuePageState.niveauQuatreLocalite);
                          });
                        },
                        underline: Container(),
                        icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                    ),
                        hint: bienvenuePageState.niveauQuatreLocalite.nom == ''
                            ? Text(subStringBydii(
                                bienvenuePageState.libelle_localite[4].libelle,
                                20))
                            : Text(subStringBydii(
                                bienvenuePageState.niveauQuatreLocalite.nom,
                                20)),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(),
      // Bureaux
      bienvenuePageState.niveauQuatreLocalite.subdivisions.length > 0
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: 50,
                width: size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Container(
                      width: size.width * 0.635,
                      child: DropdownButton(
                        items: bienvenuePageState.niveauCinq,
                        dropdownColor: quatriemeColor,
                        autofocus: true,
                        isExpanded: true,
                        itemHeight: 50,
                        focusColor: Colors.red,
                        style: GoogleFonts.averiaSansLibre(
                            fontSize: 14,
                            color: troisiemeColor,
                            fontWeight: FontWeight.w400),
                        onChanged: (t) async {
                          print('onchange => ${t.toJson()}');
                          print(bienvenuePageState.libelle_localite.length);
                          await getAllNewLocalite().then((liste) async {
                            await getSubdivisionLocalite(t, liste)
                                .then((value) {
                              bienvenuePageState.setState(() {
                                bienvenuePageState
                                    .niveauCinqLocalite.subdivisions = value;
                              });
                            });
                          });
                          bienvenuePageState.setState(() {
                            bienvenuePageState.taille_libelle = 6;
                            bienvenuePageState.niveauCinqLocalite.nom = t.nom;
                            bienvenuePageState.search_immo = bienvenuePageState
                                    .niveauZeroLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauUnLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauDeuxLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauTroisLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauQuatreLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauCinqLocalite.nom;
                            bienvenuePageState.niveauCinqLocalite.id = t.id;
                            bienvenuePageState.niveauCinqLocalite.idParent =
                                t.idParent;
                            bienvenuePageState.lastLibelle =
                                bienvenuePageState.libelle_localite.length == 6
                                    ? bienvenuePageState
                                        .libelle_localite[bienvenuePageState
                                                .libelle_localite.length -
                                            1]
                                        .libelle
                                    : bienvenuePageState
                                        .libelle_localite[6].libelle;
                            bienvenuePageState.lastLocalite = t;
                            bienvenuePageState.lastLocalite.niveau =
                                bienvenuePageState.lastLibelle;

                            bienvenuePageState.isLastLibelle =
                                bienvenuePageState.libelle_localite.length ==
                                    bienvenuePageState.taille_libelle;
                          });
                          bienvenuePageState.setState(() {
                            resetStateStep6();
                            bienvenuePageState.niveauSix = buildSousSection(
                                bienvenuePageState.niveauCinqLocalite);
                          });
                        },
                        underline: Container(),
                        icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                    ),
                        hint: bienvenuePageState.niveauCinqLocalite.nom == ''
                            ? Text(subStringBydii(
                                bienvenuePageState.libelle_localite[5].libelle,
                                20))
                            : Text(subStringBydii(
                                bienvenuePageState.niveauCinqLocalite.nom, 20)),
                      ),
                    )
                    
                  ],
                ),
              ),
            )
          : Container(),
      // Sous BUreaux
      bienvenuePageState.niveauCinqLocalite.subdivisions.length > 0
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: 50,
                width: size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Container(
                      width: size.width * 0.635,
                      child: DropdownButton(
                        items: bienvenuePageState.niveauSix,
                        dropdownColor: quatriemeColor,
                        autofocus: true,
                        isExpanded: true,
                        itemHeight: 50,
                        focusColor: Colors.red,
                        style: GoogleFonts.averiaSansLibre(
                            fontSize: 14,
                            color: troisiemeColor,
                            fontWeight: FontWeight.w400),
                        onChanged: (t) async {
                          print('onchange => ${t.toJson()}');
                          await getAllNewLocalite().then((liste) async {
                            print(liste);
                            await getSubdivisionLocalite(t, liste)
                                .then((value) {
                              bienvenuePageState.setState(() {
                                bienvenuePageState
                                    .niveauSixLocalite.subdivisions = value;
                              });
                            });
                          });
                          bienvenuePageState.setState(() {
                            bienvenuePageState.taille_libelle = 7;
                            bienvenuePageState.niveauSixLocalite.nom = t.nom;
                            bienvenuePageState.search_immo = bienvenuePageState
                                    .niveauZeroLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauUnLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauDeuxLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauTroisLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauQuatreLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauCinqLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauSixLocalite.nom;
                            bienvenuePageState.niveauSixLocalite.id = t.id;
                            bienvenuePageState.niveauSixLocalite.idParent =
                                t.idParent;
                            bienvenuePageState.lastLibelle =
                                bienvenuePageState.libelle_localite.length == 7
                                    ? bienvenuePageState
                                        .libelle_localite[bienvenuePageState
                                                .libelle_localite.length -
                                            1]
                                        .libelle
                                    : bienvenuePageState
                                        .libelle_localite[7].libelle;
                            bienvenuePageState.lastLocalite = t;
                            bienvenuePageState.lastLocalite.niveau =
                                bienvenuePageState.lastLibelle;

                            bienvenuePageState.isLastLibelle =
                                bienvenuePageState.libelle_localite.length ==
                                    bienvenuePageState.taille_libelle;
                          });
                          bienvenuePageState.setState(() {
                            resetStateStep8();
                            bienvenuePageState.niveauSept = buildSousSection(
                                bienvenuePageState.niveauSixLocalite);
                          });
                        },
                        underline: Container(),
                        icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                    ),
                        hint: bienvenuePageState.niveauSixLocalite.nom == ''
                            ? Text(subStringBydii(
                                bienvenuePageState.libelle_localite[6].libelle,
                                20))
                            : Text(subStringBydii(
                                bienvenuePageState.niveauSixLocalite.nom, 20)),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(),
      // Sous Sous Bureaux
      bienvenuePageState.niveauSixLocalite.subdivisions.length > 0
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: 50,
                width: size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Container(
                      width: size.width * 0.635,
                      child: DropdownButton(
                        items: bienvenuePageState.niveauSept,
                        dropdownColor: quatriemeColor,
                        autofocus: true,
                        isExpanded: true,
                        itemHeight: 50,
                        focusColor: Colors.red,
                        style: GoogleFonts.averiaSansLibre(
                            fontSize: 14,
                            color: troisiemeColor,
                            fontWeight: FontWeight.w400),
                        onChanged: (t) async {
                          await getAllNewLocalite().then((liste) async {
                            await getSubdivisionLocalite(t, liste)
                                .then((value) {
                              bienvenuePageState.setState(() {
                                bienvenuePageState
                                    .niveauSeptLocalite.subdivisions = value;
                              });
                            });
                          });
                          bienvenuePageState.setState(() {
                            bienvenuePageState.taille_libelle = 8;
                            bienvenuePageState.niveauSeptLocalite.nom = t.nom;
                            bienvenuePageState.search_immo = bienvenuePageState
                                    .niveauZeroLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauUnLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauDeuxLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauTroisLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauQuatreLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauCinqLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauSixLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauSeptLocalite.nom;
                            bienvenuePageState.niveauSeptLocalite.id = t.id;
                            bienvenuePageState.niveauSeptLocalite.idParent =
                                t.idParent;
                            bienvenuePageState.lastLibelle =
                                bienvenuePageState.libelle_localite.length == 8
                                    ? bienvenuePageState
                                        .libelle_localite[bienvenuePageState
                                                .libelle_localite.length -
                                            1]
                                        .libelle
                                    : bienvenuePageState
                                        .libelle_localite[8].libelle;
                            bienvenuePageState.lastLocalite = t;
                            bienvenuePageState.lastLocalite.niveau =
                                bienvenuePageState.lastLibelle;

                            bienvenuePageState.isLastLibelle =
                                bienvenuePageState.libelle_localite.length ==
                                    bienvenuePageState.taille_libelle;
                          });
                          bienvenuePageState.setState(() {
                            resetStateStep9();
                            bienvenuePageState.niveauHuit = buildSousSection(
                                bienvenuePageState.niveauSeptLocalite);
                          });
                        },
                        underline: Container(),
                        icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                    ),
                        hint: bienvenuePageState.niveauSeptLocalite.nom == ''
                            ? Text(subStringBydii(
                                bienvenuePageState.libelle_localite[7].libelle,
                                20))
                            : Text(subStringBydii(
                                bienvenuePageState.niveauSeptLocalite.nom, 20)),
                      ),
                    )
                    
                  ],
                ),
              ),
            )
          : Container(),
      // Sous Sous Sous Bureau
      bienvenuePageState.niveauSeptLocalite.subdivisions.length > 0
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: 50,
                width: size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Container(
                      width: size.width * 0.635,
                      child: DropdownButton(
                        items: bienvenuePageState.niveauHuit,
                        dropdownColor: quatriemeColor,
                        autofocus: true,
                        isExpanded: true,
                        itemHeight: 50,
                        focusColor: Colors.red,
                        style: GoogleFonts.averiaSansLibre(
                            fontSize: 14,
                            color: troisiemeColor,
                            fontWeight: FontWeight.w400),
                        onChanged: (t) async {
                          await getAllNewLocalite().then((liste) async {
                            await getSubdivisionLocalite(t, liste)
                                .then((value) {
                              bienvenuePageState.setState(() {
                                bienvenuePageState
                                    .niveauHUitLocalite.subdivisions = value;
                              });
                            });
                          });
                          bienvenuePageState.setState(() {
                            bienvenuePageState.taille_libelle = 9;
                            bienvenuePageState.niveauHUitLocalite.nom = t.nom;
                            bienvenuePageState.search_immo = bienvenuePageState
                                    .niveauZeroLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauUnLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauDeuxLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauTroisLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauQuatreLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauCinqLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauSixLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauSeptLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauHUitLocalite.nom;
                            bienvenuePageState.niveauHUitLocalite.id = t.id;
                            bienvenuePageState.niveauHUitLocalite.idParent =
                                t.idParent;
                            bienvenuePageState.lastLibelle =
                                bienvenuePageState.libelle_localite.length == 9
                                    ? bienvenuePageState
                                        .libelle_localite[bienvenuePageState
                                                .libelle_localite.length -
                                            1]
                                        .libelle
                                    : bienvenuePageState
                                        .libelle_localite[10].libelle;
                            bienvenuePageState.lastLocalite = t;
                            bienvenuePageState.lastLocalite.niveau =
                                bienvenuePageState.lastLibelle;

                            bienvenuePageState.isLastLibelle =
                                bienvenuePageState.libelle_localite.length ==
                                    bienvenuePageState.taille_libelle;
                          });
                          bienvenuePageState.setState(() {
                            resetStateStep10();
                            bienvenuePageState.niveauNeuf = buildSousSection(
                                bienvenuePageState.niveauHUitLocalite);
                          });
                        },
                        underline: Container(),
                        icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                    ),
                        hint: bienvenuePageState.niveauHUitLocalite.nom == ''
                            ? Text(subStringBydii(
                                bienvenuePageState.libelle_localite[7].libelle,
                                20))
                            : Text(subStringBydii(
                                bienvenuePageState.niveauHUitLocalite.nom, 20)),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(),
      // Sous Sous Sous Sous Bureaux
      bienvenuePageState.niveauHUitLocalite.subdivisions.length > 0
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: 50,
                width: size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Container(
                      width: size.width * 0.635,
                      child: DropdownButton(
                        items: bienvenuePageState.niveauNeuf,
                        dropdownColor: quatriemeColor,
                        autofocus: true,
                        isExpanded: true,
                        itemHeight: 50,
                        focusColor: Colors.red,
                        style: GoogleFonts.averiaSansLibre(
                            fontSize: 14,
                            color: troisiemeColor,
                            fontWeight: FontWeight.w400),
                        onChanged: (t) async {
                          await getAllNewLocalite().then((liste) async {
                            await getSubdivisionLocalite(t, liste)
                                .then((value) {
                              bienvenuePageState.setState(() {
                                bienvenuePageState
                                    .niveauNeufLocalite.subdivisions = value;
                              });
                            });
                          });
                          bienvenuePageState.setState(() {
                            bienvenuePageState.niveauNeufLocalite.nom = t.nom;
                            bienvenuePageState.niveauHUitLocalite.nom = t.nom;
                            bienvenuePageState.search_immo = bienvenuePageState
                                    .niveauZeroLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauUnLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauDeuxLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauTroisLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauQuatreLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauCinqLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauSixLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauSeptLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauHUitLocalite.nom +
                                '*' +
                                bienvenuePageState.niveauNeufLocalite.nom;
                            bienvenuePageState.niveauNeufLocalite.id = t.id;
                            bienvenuePageState.niveauNeufLocalite.idParent =
                                t.idParent;
                            bienvenuePageState.lastLibelle =
                                bienvenuePageState.libelle_localite.length == 10
                                    ? bienvenuePageState
                                        .libelle_localite[bienvenuePageState
                                                .libelle_localite.length -
                                            1]
                                        .libelle
                                    : bienvenuePageState
                                        .libelle_localite[10].libelle;
                            bienvenuePageState.lastLocalite = t;
                            bienvenuePageState.lastLocalite.niveau =
                                bienvenuePageState.lastLibelle;

                            bienvenuePageState.isLastLibelle =
                                bienvenuePageState.libelle_localite.length ==
                                    bienvenuePageState.taille_libelle;
                          });
                          bienvenuePageState.setState(() {
                            resetStateStep11();
                            bienvenuePageState.niveauDix = buildSousSection(
                                bienvenuePageState.niveauNeufLocalite);
                          });
                        },
                        underline: Container(),
                        icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                    ),
                        hint: bienvenuePageState.niveauNeufLocalite.nom == ''
                            ? Text(subStringBydii(
                                bienvenuePageState.libelle_localite[6].libelle,
                                20))
                            : Text(subStringBydii(
                                bienvenuePageState.niveauNeufLocalite.nom, 20)),
                      ),
                    )
                    
                  ],
                ),
              ),
            )
          : Container(),
      Container(
        height: 50,
        width: size.width,
      )
    ],
  );
}
