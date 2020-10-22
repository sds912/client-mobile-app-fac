import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/models/inventaire.dart';
import 'package:v1/models/libelle_localite.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/colors.dart';
import 'package:v1/utils/dropdown/entreprise.dart';
import 'package:v1/utils/text-utils.dart';
import 'package:v1/utils/web.dart';

choiceEntrepriseHelper(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  bienvenuePageState.setState(() {
    bienvenuePageState.entrepriseDropdown = buildEntreprise();
  });
  return ListView(
    padding: EdgeInsets.all(8.0),
    physics: BouncingScrollPhysics(),
    children: [
      // Continent
      Padding(
        padding: const EdgeInsets.only(left: 0.0, top: 16),
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
                  items: bienvenuePageState.entrepriseDropdown,
                  dropdownColor: quatriemeColor,
                  itemHeight: 50,
                  focusColor: Colors.red,
                  style: GoogleFonts.averiaSansLibre(
                      fontSize: 14,
                      color: troisiemeColor,
                      fontWeight: FontWeight.w400),
                  onChanged: (t) async {
                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = -1;
                    });
                    await UtilsHttp.getByIssa('/mobile-inventaire/${t.id}')
                        .then((value) {
                      var data = json.decode(value.data);
                      bienvenuePageState.inventaire = Inventaire.fromJson(data);
                      bienvenuePageState.setState(() {
                        bienvenuePageState.immos =
                            Immobilisation.fromJson(data);
                      });
                    });
                    await UtilsHttp.getByIssa('/mobile-locality/${t.id}')
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
                  },
                  underline: Container(),
                  icon: Container(),
                  hint: bienvenuePageState.entreprise.denomination == ''
                      ? Text(subStringBydii('Choisir votre entreprise', 28))
                      : Text(subStringBydii(
                          bienvenuePageState.entreprise.denomination, 20)),
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
      ),
      Container(
        height: 50,
        width: size.width,
      )
    ],
  );
}
