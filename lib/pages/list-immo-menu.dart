import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/search-utils.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/text-utils.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/top-navBar.dart';

int i = 0;

listImmoMenu(context) {
  if (bienvenuePageState.isStartingSearch) {
    getImmobilisationListFile().then((value) => bienvenuePageState.setState(() {
          bienvenuePageState.immos_scanne_menu = value;
        }));
  }
  bienvenuePageState.setState(() {
    bienvenuePageState.isTwo = true;
  });
  Size size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.height,
        color: Colors.white,
      ),
      Positioned(
        top: size.height * .185,
        child: Container(
          height: size.height * .7,
          width: size.width,
          color: Colors.grey[50],
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              getTable(bienvenuePageState.immos_scanne_menu, context),
            ],
          ),
        ),
      ),
      Positioned(
        top: size.height * .18,
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
                  width: size.width * .35,
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
                  width: size.width * .35,
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
                Container(
                  width: 2,
                  color: Colors.white,
                ),
                Container(
                  width: size.width * .25,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 32.0),
                      child: Text(
                        'Zone',
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
        top: size.height * .13,
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
      Positioned(
          top: size.height * .05,
          child: Container(
            height: size.height * 0.08,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textAlign: TextAlign.start,
                onChanged: (String t) {
                  sarchByDii(t, bienvenuePageState.immos_scanne);
                },
                style: TextStyle(fontSize: 18, color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 36.0,
                    color: Colors.white,
                  ),
                  // suffixIcon: Icon(Icons.search, size: 36.0, color: Colors.white,),
                  hintText: "Recherche",
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5)),
          )),
      positionedTopNavbar(size),
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
                    child: Row(
                      children: [
                        item.image == ''
                            ? Container()
                            : Icon(
                                Icons.photo,
                                size: 14.0,
                                color: Colors.orange[700],
                              ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          item.code,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.averiaSerifLibre(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ), onTap: () {
                bienvenuePageState.setState(() {
                  bienvenuePageState.immobilisation_detail = item;
                  bienvenuePageState.screenWelcome = 9;
                });
              }),
              DataCell(
                Container(
                    child: Text(
                  item.libelle.length > 12
                      ? item.libelle.substring(0, 12)
                      : item.libelle,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.averiaSerifLibre(
                      fontSize: 10, fontWeight: FontWeight.w300),
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
                    child: Row(
                  children: [
                    Text(
                      item.emplacement_string,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.averiaSerifLibre(
                          fontSize: 10, fontWeight: FontWeight.w300),
                    ),
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
                    // color: Colors.blue,
                    child: Row(
                      children: [
                        item.image == ''
                            ? Container()
                            : Icon(
                                Icons.photo,
                                size: 14.0,
                                color: Colors.orange[700],
                              ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          item.code,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.averiaSerifLibre(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ), onTap: () {
                bienvenuePageState.setState(() {
                  bienvenuePageState.immobilisation_detail = item;
                  bienvenuePageState.screenWelcome = 9;
                });
              }),
              DataCell(
                Container(
                    child: Text(
                  item.libelle.length > 12
                      ? item.libelle.substring(0, 12)
                      : item.libelle,
                  style: GoogleFonts.averiaSerifLibre(
                      fontSize: 10, fontWeight: FontWeight.w300),
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
                    // color: Colors.blue,
                    child: Text(
                  item.emplacement_string != '' ? item.emplacement_string : '',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.averiaSerifLibre(
                      fontSize: 10, fontWeight: FontWeight.w300),
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
        DataCell(Container()),
      ]));

  return l;
}

Widget getTable(List<Immobilisation> p, BuildContext context) {
  return DataTable(
      columnSpacing: 0.0,
      horizontalMargin: 0.0,
      sortAscending: true,
      columns: [
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
      ],
      rows: getDataRow(p, context));
}
