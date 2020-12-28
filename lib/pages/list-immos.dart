import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/getUserRole.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/web.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/showDialogError.dart';
import 'package:v1/widget/top-navBar.dart';

import 'dart:io' as Io;

// int i = 0;

listImmo(context) {
  Size size = MediaQuery.of(context).size;
  TextEditingController _controller = TextEditingController();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  bienvenuePageState.setState(() {
    bienvenuePageState.isTwo = false;
  });
  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.height,
        color: Colors.white,
      ),
      Positioned(
        child: TextField(
          showCursor: false,
          controller: _controller,
          enabled: true,
          autofocus: true,
          onSubmitted: (t) {
            _controller.text = '';
            if (bienvenuePageState.lastLocalite.id != 0) {
              for (var immo in bienvenuePageState.immos) {
                if (immo.code == t.trim()) {
                  bienvenuePageState.setState(() {
                    bienvenuePageState.isImmoHere = true;
                    bienvenuePageState.immo = immo;
                    bienvenuePageState.immo.emplacement_string =
                        bienvenuePageState.lastLocalite.nom;
                    bienvenuePageState.immo.search_list =
                        bienvenuePageState.search_immo;
                    bienvenuePageState.immo.lecteur =
                        bienvenuePageState.user.nom;
                    bienvenuePageState.immo.dateTime =
                        DateTime.now().toString();
                  });
                }
              }
              if (bienvenuePageState.isImmoHere) {
                verifIfImmoHereInSharedPreference(bienvenuePageState.immo)
                    .then((verif) {
                  if (verif) {
                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = 14;
                    });
                  } else {
                    if (bienvenuePageState.etat_du_bien) {
                      bienvenuePageState.setState(() {
                        bienvenuePageState.screenWelcome = 13;
                      });
                    } else {
                      bienvenuePageState.setState(() {
                        bienvenuePageState.immo.etat = '1';
                        bienvenuePageState.immo.status = '1';
                        bienvenuePageState.immo.emplacement =
                            bienvenuePageState.lastLocalite.id.toString();
                        bienvenuePageState.immo.search_list =
                            bienvenuePageState.search_immo;
                        bienvenuePageState.immo.emplacement_string =
                            bienvenuePageState.lastLocalite.nom;
                        bienvenuePageState.immos_scanne
                            .add(bienvenuePageState.immo);
                        setImmobilisationListFile(bienvenuePageState.immo);
                        setImmobilisationListFileJson(bienvenuePageState.immo);
                      });
                      sendDataRealTime();
                      FocusScope.of(context).nextFocus();
                    }
                  }
                });
                bienvenuePageState.setState(() {
                  bienvenuePageState.isImmoHere = false;
                });
              } else {
                bienvenuePageState.setState(() {
                  bienvenuePageState.immo = new Immobilisation(
                      id: 0,
                      libelle: '',
                      commentaire: '',
                      description: '',
                      code: t.trim(),
                      lecteur: bienvenuePageState.user.nom,
                      emplacement:
                          bienvenuePageState.lastLocalite.id.toString(),
                      etat: '');

                  bienvenuePageState.isNewImmo = true;

                  bienvenuePageState.isImmoHere = false;
                });
                verifIfImmoHereInSharedPreference(bienvenuePageState.immo)
                    .then((verif) {
                  if (verif) {
                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = 14;
                    });
                  } else {
                    print(bienvenuePageState.immo.toString());
                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = 5;
                      bienvenuePageState.shwoCardRechercheCatalogue = true;
                      bienvenuePageState.isImmoHere = false;
                    });
                  }
                });
              }
            }
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: ''),
        ),
      ),
      Positioned(
        top: size.height * .105,
        child: Container(
          height: size.height * .7,
          width: size.width,
          color: Colors.white38,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              getTable(bienvenuePageState.immos_scanne, context),
            ],
          ),
        ),
      ),
      Positioned(
        top: size.height * .1,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            height: 40,
            width: size.width,
            color: Colors.grey[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: size.width * .3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 45.0, top: 8.0),
                    child: Text(
                      'Code',
                      style: GoogleFonts.averiaSansLibre(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.white,
                ),
                Container(
                  width: size.width * .4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 38.0),
                    child: Text(
                      'Description',
                      style: GoogleFonts.averiaSansLibre(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.white,
                ),
                Container(
                  width: size.width * .27,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(
                      'Etat du bien',
                      style: GoogleFonts.averiaSansLibre(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: size.height * .05,
        child: Container(
          height: size.height * .07,
          width: size.width,
          color: Colors.grey[200],
          child: Center(
            child: Text(
              'Liste des immobilisations scannées',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      positionedTopNavbar(size),
      getUserRoleBool(bienvenuePageState.user) && !bienvenuePageState.isCloseInv
          ? Positioned(
              top: size.height * .82,
              left: size.width * .2,
              child: GestureDetector(
                onTap: () async => showDialogErrorComptage(
                    context: context, msg: 'Voulez vous clotûrer le comptage?'),
                child: Container(
                  height: size.height * .07,
                  width: size.width * .6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/cloturer_zone.png'))),
                ),
              ))
          : getUserRoleBool(bienvenuePageState.user) &&
                  bienvenuePageState.isCloseInv
              ? Positioned(
                  top: size.height * .82,
                  left: size.width * .2,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: size.height * .07,
                      width: size.width * .6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/cloturer_comptage_gris.png'))),
                    ),
                  ))
              : Container(),
      positionedBottumNav(size, 4)
    ],
  );
}

List<DataRow> getDataRow(List<Immobilisation> liste, BuildContext context) {
  List<DataRow> l = [];
  int i = 0;
  Size size = MediaQuery.of(context).size;
  if (liste.length > 0) {
    for (var item in liste) {
      i = i + 1;

      if (i % 2 == 0) {
        l.add(DataRow(
            color: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return Colors.grey[50];
            }),
            cells: [
              DataCell(
                  Container(
                    width: size.width * .2,
                    child: Center(
                      child: Text(
                        item.code.length > 12
                            ? item.code.substring(0, 12)
                            : item.code,
                        style: GoogleFonts.averiaSerifLibre(
                            fontSize: 10, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ), onTap: () {
                bienvenuePageState.setState(() {
                  bienvenuePageState.immobilisation_detail = item;
                  bienvenuePageState.screenWelcome = 9;
                });
              }),
              DataCell(
                Container(
                    width: size.width * .3,
                    // color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item.libelle.length > 12
                              ? item.libelle.substring(0, 10)
                              : item.libelle,
                          style: GoogleFonts.averiaSerifLibre(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        item.image == ''
                            ? Container()
                            : Icon(
                                Icons.photo,
                                color: Colors.orange[700],
                              )
                      ],
                    )),
                onTap: () {
                  bienvenuePageState.setState(() {
                    bienvenuePageState.immobilisation_detail = item;
                    bienvenuePageState.screenWelcome = 9;
                  });
                },
              ),
              DataCell(
                Container(
                    width: size.width * .1,
                    // color: Colors.blue,
                    child: item.etat == '1'
                        ? Icon(
                            Icons.check_box_rounded,
                            size: 28,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.stop_rounded,
                            size: 40,
                            color: Colors.red,
                          )),
                onTap: () {
                  if (item.etat == '1' && item.image == '') {
                    ImagePicker.pickImage(
                            source: ImageSource.camera,
                            maxHeight: 800,
                            maxWidth: 1200)
                        .then((file) async {
                      Io.File compressedFile =
                          await FlutterNativeImage.compressImage(file.path,
                              quality: 80,
                              percentage: 80,
                              targetHeight: 800,
                              targetWidth: 1200);
                      var bytes = new Io.File(compressedFile.path);
                      var image = bytes.readAsBytesSync();
                      String base64Encode(List<int> image) =>
                          base64.encode(image);
                      bienvenuePageState.setState(() {
                        bienvenuePageState
                            .immos_scanne[bienvenuePageState.immos_scanne
                                .lastIndexWhere((element) =>
                                    element.id == item.id &&
                                    element.dateTime == item.dateTime)]
                            .etat = item.etat == '1' ? '0' : '1';
                        bienvenuePageState
                            .immos_scanne[bienvenuePageState.immos_scanne
                                .lastIndexWhere((element) =>
                                    element.id == item.id &&
                                    element.dateTime == item.dateTime)]
                            .image = base64Encode(image);
                      });
                      setImmobilisationListFile(bienvenuePageState.immo);

                      setListImmobilisationFileJson(
                          bienvenuePageState.immos_scanne);

                      sendDataRealTime();
                    });
                  } else if (item.etat == '1' && item.image != '') {
                    bienvenuePageState.setState(() {
                      bienvenuePageState
                          .immos_scanne[bienvenuePageState.immos_scanne
                              .lastIndexWhere((element) =>
                                  element.id == item.id &&
                                  element.dateTime == item.dateTime)]
                          .etat = '0';
                    });
                    setImmobilisationListFile(bienvenuePageState.immo);

                    setListImmobilisationFileJson(
                        bienvenuePageState.immos_scanne);

                    sendDataRealTime();
                  } else if (item.etat == '0' && item.image != '') {
                    bienvenuePageState.setState(() {
                      bienvenuePageState
                          .immos_scanne[bienvenuePageState.immos_scanne
                              .lastIndexWhere((element) =>
                                  element.id == item.id &&
                                  element.dateTime == item.dateTime)]
                          .etat = '1';
                    });
                    setImmobilisationListFile(bienvenuePageState.immo);

                    setListImmobilisationFileJson(
                        bienvenuePageState.immos_scanne);

                    sendDataRealTime();
                  }
                },
              ),
            ]));
      } else {
        l.add(DataRow(
            color: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return Colors.grey[200];
            }),
            cells: [
              DataCell(
                  Container(
                    width: size.width * .2,
                    // color: Colors.red,
                    child: Text(
                      item.code.length > 12
                          ? item.code.substring(0, 12)
                          : item.code,
                      style: GoogleFonts.averiaSerifLibre(
                          fontSize: 10, fontWeight: FontWeight.w300),
                    ),
                  ), onTap: () {
                bienvenuePageState.setState(() {
                  bienvenuePageState.immobilisation_detail = item;
                  bienvenuePageState.screenWelcome = 9;
                });
              }),
              DataCell(
                Container(
                    width: size.width * .3,
                    // color: Colors.blue,
                    child: Row(
                      children: [
                        Text(
                          item.libelle.length > 12
                              ? item.libelle.substring(0, 10)
                              : item.libelle,
                          style: GoogleFonts.averiaSerifLibre(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        item.image == ''
                            ? Container()
                            : Icon(
                                Icons.photo,
                                color: Colors.orange[700],
                              )
                      ],
                    )),
                onTap: () {
                  bienvenuePageState.setState(() {
                    bienvenuePageState.immobilisation_detail = item;
                    bienvenuePageState.screenWelcome = 9;
                  });
                },
              ),
              DataCell(
                Container(
                    width: size.width * .1,
                    // color: Colors.blue,
                    child: item.etat == '1'
                        ? Icon(
                            Icons.check_box_rounded,
                            color: Colors.green,
                            size: 28,
                          )
                        : Icon(
                            Icons.stop_rounded,
                            size: 40,
                            color: Colors.red,
                          )),
                onTap: () {
                  if (item.etat == '1' && item.image == '') {
                    ImagePicker.pickImage(
                            source: ImageSource.camera,
                            maxHeight: 800,
                            maxWidth: 1200)
                        .then((file) async {
                      Io.File compressedFile =
                          await FlutterNativeImage.compressImage(file.path,
                              quality: 80,
                              percentage: 80,
                              targetHeight: 800,
                              targetWidth: 1200);
                      var bytes = new Io.File(compressedFile.path);
                      var image = bytes.readAsBytesSync();
                      String base64Encode(List<int> image) =>
                          base64.encode(image);
                      bienvenuePageState.setState(() {
                        bienvenuePageState
                            .immos_scanne[bienvenuePageState.immos_scanne
                                .lastIndexWhere((element) =>
                                    element.id == item.id &&
                                    element.dateTime == item.dateTime)]
                            .etat = item.etat == '1' ? '0' : '1';
                        bienvenuePageState
                            .immos_scanne[bienvenuePageState.immos_scanne
                                .lastIndexWhere((element) =>
                                    element.id == item.id &&
                                    element.dateTime == item.dateTime)]
                            .image = base64Encode(image);
                      });
                      setImmobilisationListFile(bienvenuePageState.immo);
                      setListImmobilisationFileJson(
                          bienvenuePageState.immos_scanne);

                      sendDataRealTime();
                    });
                  } else if (item.etat == '1' && item.image != '') {
                    bienvenuePageState.setState(() {
                      bienvenuePageState
                          .immos_scanne[bienvenuePageState.immos_scanne
                              .lastIndexWhere((element) =>
                                  element.id == item.id &&
                                  element.dateTime == item.dateTime)]
                          .etat = '0';
                    });
                    setImmobilisationListFile(bienvenuePageState.immo);

                    setListImmobilisationFileJson(
                        bienvenuePageState.immos_scanne);

                    sendDataRealTime();
                  } else if (item.etat == '0' && item.image != '') {
                    bienvenuePageState.setState(() {
                      bienvenuePageState
                          .immos_scanne[bienvenuePageState.immos_scanne
                              .lastIndexWhere((element) =>
                                  element.id == item.id &&
                                  element.dateTime == item.dateTime)]
                          .etat = '1';
                    });
                    setImmobilisationListFile(bienvenuePageState.immo);

                    setListImmobilisationFileJson(
                        bienvenuePageState.immos_scanne);

                    sendDataRealTime();
                  }
                },
              ),
            ]));
      }
    }
  }

  l.add(DataRow(
      color:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        return Colors.grey[50];
      }),
      cells: [
        DataCell(Container()),
        DataCell(Container()),
        DataCell(Container()),
      ]));

  return l;
}

Widget getTable(List<Immobilisation> p, BuildContext context) {
  return DataTable(
      columnSpacing: 16.0,
      horizontalMargin: 24.0,
      sortAscending: true,
      columns: [
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
      ],
      rows: getDataRow(p, context));
}
