import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/colors.dart';
import 'package:v1/utils/dropdown/sous-section.dart';
import 'package:v1/utils/reset-step.dart';
import 'package:v1/utils/text-utils.dart';
import 'package:v1/utils/shared-preference.dart';


Padding paddingDrownButton0({Size size , bool isLast = false})  {
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
                    bienvenuePageState.niveauZeroLocalite.nom = t.nom;
                    bienvenuePageState.niveauZeroLocalite.id = t.id;
                    bienvenuePageState.niveauZeroLocalite.idParent =
                        t.idParent;
                    bienvenuePageState.lastLibelle = isLast ? bienvenuePageState.libelle_localite[bienvenuePageState.libelle_localite.length - 1].libelle  :
                        bienvenuePageState.libelle_localite[1].libelle;
                    bienvenuePageState.lastLocalite = t;
                    bienvenuePageState.isLastLibelle = isLast;
                  });
                  bienvenuePageState.setState(() {
                    resetStateStep0();
                    bienvenuePageState.niveauUn = buildSousSection(
                        bienvenuePageState.niveauZeroLocalite);
                  });
                },
                underline: Container(),
                icon: Container(),
                hint: bienvenuePageState.niveauZeroLocalite.nom == ''
                    ? Text(subStringBydii(
                        bienvenuePageState.libelle_localite[0].libelle, 20))
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