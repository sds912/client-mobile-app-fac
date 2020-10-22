import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/colors.dart';
import 'package:v1/utils/dropdown/section.dart';
import 'package:v1/utils/dropdown/sous-section.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/text-utils.dart';

step(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  bienvenuePageState.setState(() {
    if (bienvenuePageState.isListDRowDown) {
      bienvenuePageState.niveauZero = buildSection();
      bienvenuePageState.listeStepDrowDown.add(paddingDrowDownStep0(size));
    }
  });

  return ListView(
    padding: EdgeInsets.all(8.0),
    physics: BouncingScrollPhysics(),
    children: bienvenuePageState.listeStepDrowDown,
  );
}

Padding paddingDrowDownStep0(
  Size size,
) {
  return Padding(
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
            width: size.width * 0.45,
            child: DropdownButton(
              items: bienvenuePageState.niveauZero,
              dropdownColor: quatriemeColor,
              autofocus: true,
              itemHeight: 50,
              focusColor: Colors.red,
              style: GoogleFonts.averiaSansLibre(
                  fontSize: 14,
                  color: troisiemeColor,
                  fontWeight: FontWeight.w400),
              onChanged: (t) async => onChangeHandler0(size, t),
              underline: Container(),
              icon: Container(),
              hint: bienvenuePageState.niveauZeroLocalite.nom == ''
                  ? Text(subStringBydii(
                      bienvenuePageState
                          .libelle_localite[getIntNiveau(
                              bienvenuePageState.niveauZeroLocalite.niveau)]
                          .libelle,
                      20))
                  : Text(subStringBydii(
                      bienvenuePageState.niveauZeroLocalite.nom, 20)),
            ),
          ),
          SizedBox(
            width: size.width * .08,
          ),
          Icon(
            Icons.arrow_drop_down_outlined,
            size: 28,
          )
        ],
      ),
    ),
  );
}

Padding paddingDrowDownStep1(
  Size size,
) {
  return Padding(
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
            width: size.width * 0.45,
            child: DropdownButton(
              items: bienvenuePageState.niveauUn,
              dropdownColor: quatriemeColor,
              autofocus: true,
              itemHeight: 50,
              // focusColor: Colors.red,
              style: GoogleFonts.averiaSansLibre(
                  fontSize: 14,
                  color: troisiemeColor,
                  fontWeight: FontWeight.w400),
              onChanged: (t) async => onChangeHandler1(size),
              underline: Container(),
              icon: Container(),
              hint: bienvenuePageState.niveauUnLocalite.nom == ''
                  ? Text(subStringBydii(
                      bienvenuePageState
                          .libelle_localite[getIntNiveau(
                              bienvenuePageState.niveauUnLocalite.niveau)]
                          .libelle,
                      20))
                  : Text(subStringBydii(
                      bienvenuePageState.niveauUnLocalite.nom, 20)),
            ),
          ),
          SizedBox(
            width: size.width * .08,
          ),
          Icon(
            Icons.arrow_drop_down_outlined,
            size: 28,
          )
        ],
      ),
    ),
  );
}

onChangeHandler0(Size size, Localites ln) async {
  print('here 0');
  print(ln.toJson());
  bienvenuePageState.setState(() {
    bienvenuePageState.isListDRowDown = false;
  });
  await getAllNewLocalite().then((liste) async {
    await getSubdivisionLocalite(ln, liste).then((value) {
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauZeroLocalite.subdivisions = value;
      });
    });
  });

  bienvenuePageState.setState(() {
    bienvenuePageState.niveauUn =
        buildSousSection(bienvenuePageState.niveauZeroLocalite);
    if (bienvenuePageState.niveauUn.length > 0) {
      bienvenuePageState.listeStepDrowDown.add(paddingDrowDownStep1(
        size,
      ));
    }
  });
}

onChangeHandler1(Size size) async {
  print('here 1');
  await getAllNewLocalite().then((liste) async {
    await getSubdivisionLocalite(bienvenuePageState.niveauUnLocalite, liste)
        .then((value) {
      bienvenuePageState.setState(() {
        bienvenuePageState.niveauUnLocalite.subdivisions = value;
      });
    });
  });
  bienvenuePageState.setState(() {
    bienvenuePageState.niveauDeux =
        buildSousSection(bienvenuePageState.niveauUnLocalite);
    if (bienvenuePageState.niveauUn.length > 0) {
      bienvenuePageState.listeStepDrowDown.add(paddingDrowDownStep1(
        size,
      ));
    }
  });
}
