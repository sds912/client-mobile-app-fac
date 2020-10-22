import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/getUserRole.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/showDialogError.dart';
import 'package:v1/widget/top-navBar.dart';

int i = 0;

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
                if (immo.code == t) {
                  bienvenuePageState.setState(() {
                    bienvenuePageState.isImmoHere = true;
                    bienvenuePageState.immo = immo;
                    bienvenuePageState.immo.emplacement_string =
                        bienvenuePageState.lastLocalite.nom;
                        bienvenuePageState.immo.search_list = bienvenuePageState.search_immo;
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
                    // showDialogError(
                    //     context: context, msg: "immobilisations déjà scannée");

                    // page Immo déjas Scanne
                  } else {
                    // showDialogEtatDuBien(context, 1);
                    // go aother Page
                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = 13;
                    });
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
                      code: t,
                      lecteur: bienvenuePageState.user.nom,
                      emplacement: '',
                      etat: '');
                  bienvenuePageState.isImmoHere = false;
                });
                verifIfImmoHereInSharedPreference(bienvenuePageState.immo)
                    .then((verif) {
                  if (verif) {
                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = 14;
                    });
                    // showDialogError(
                    //     context: context, msg: "immobilisations déjà scannée");
                  } else {
                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = 5;
                      bienvenuePageState.isImmoHere = false;
                    });
                  }
                });
              }
            }
          },
          // bienvenuePageState.setState(() {
          //   bienvenuePageState.isImmoHere = false;
          // });
          // FocusScope.of(context).previousFocus();
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
          color: Colors.grey[50],
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
                  width: size.width * .45,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Code',
                        style: GoogleFonts.averiaSansLibre(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.white,
                ),
                Container(
                  width: size.width * .45,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 32.0),
                      child: Text(
                        'Description',
                        style: GoogleFonts.averiaSansLibre(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.white),
                      ),
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
                    context: context,
                    msg:
                        'Voulez vous clotûrer le comptage?'),
                child: Container(
                  height: size.height * .07,
                  width: size.width * .6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/clotuer_comptage.png'))),
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
                    width: size.width * .4,
                    child: Text(
                      item.code,
                      style: GoogleFonts.averiaSerifLibre(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ), onTap: () {
                bienvenuePageState.setState(() {
                  bienvenuePageState.immobilisation_detail = item;
                  bienvenuePageState.screenWelcome = 9;
                });
              }),
              DataCell(
                Container(
                    width: size.width * .4,
                    // color: Colors.blue,
                    child: Row(
                      children: [
                        Text(
                          item.libelle.length > 12
                              ? item.libelle.substring(0, 12) 
                              : item.libelle,
                          style: GoogleFonts.averiaSerifLibre(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(width: 10,),
                        item.image =='' ? Container() : Icon(Icons.photo , color: Colors.orange[700],)
                      ],
                    )),
                onTap: () {
                  bienvenuePageState.setState(() {
                    bienvenuePageState.immobilisation_detail = item;
                    bienvenuePageState.screenWelcome = 9;
                  });
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
                    width: size.width * .4,
                    child: Text(
                      item.code,
                      style: GoogleFonts.averiaSerifLibre(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ), onTap: () {
                bienvenuePageState.setState(() {
                  bienvenuePageState.immobilisation_detail = item;
                  bienvenuePageState.screenWelcome = 9;
                });
              }),
              DataCell(
                Container(
                    width: size.width * .4,
                    child: Text(
                      item.libelle.length > 12
                          ? item.libelle.substring(0, 12)
                          : item.libelle,
                      style: GoogleFonts.averiaSerifLibre(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    )),
                onTap: () {
                  bienvenuePageState.setState(() {
                    bienvenuePageState.immobilisation_detail = item;
                    bienvenuePageState.screenWelcome = 9;
                  });
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
      ]));

  l.add(DataRow(
      color:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        return Colors.grey[200];
      }),
      cells: [
        DataCell(Container()),
        DataCell(Container()),
      ]));
  l.add(DataRow(
      color:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        return Colors.grey[50];
      }),
      cells: [
        DataCell(Container()),
        DataCell(Container()),
      ]));

  return l;
}

Widget getTable(List<Immobilisation> p, BuildContext context) {
  return DataTable(
      columnSpacing: 56.0,
      horizontalMargin: 24.0,
      sortAscending: true,
      columns: [
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
      ],
      rows: getDataRow(p, context));
}
