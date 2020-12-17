import 'package:flutter/material.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/step-localite.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/showDialogError.dart';
import 'package:v1/widget/top-navBar.dart';

stepPage(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  if (bienvenuePageState.isTailleLibDiff) {
    getListLibelleLocalite().then((liste) {
      bienvenuePageState.setState(() {
        bienvenuePageState.libelle_localite.addAll(liste);
        print(bienvenuePageState.libelle_localite);
        bienvenuePageState.isTailleLibDiff = false;
      });
    });
  }
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
          top: size.height * .05,
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
          top: size.height * .21,
          left: size.width * .1,
          child: Container(
            height: size.height * .1,
            width: size.width * .8,
            child: Center(
                child: Text(
              bienvenuePageState.lastLocalite.id == '0'
                  ? 'Sélectionnez Une Localité'
                  : 'Procéder au comptage',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: bienvenuePageState.lastLocalite.id == '0' ? 24 : 26,
                  fontStyle: FontStyle.normal),
            )),
          )),
      Positioned(
        top: size.height * .3,
        left: size.width * .075,
        child: buildStepLocalite(context),
      ),
      !bienvenuePageState.isNewImmo
          ? Positioned(
              top: size.height * .81,
              left: size.width * .2,
              child: GestureDetector(
                onTap: () {
                  if (bienvenuePageState.lastLocalite.id == '0') {
                    showDialogError(
                        context: context,
                        msg: "Choisir une localité pour débuter le scanne");
                  } else {
                    getCloseComptageZone(bienvenuePageState.lastLocalite)
                        .then((verif) {
                      if (verif) {
                        showDialogErrorComptageDeblocage(
                            context: context,
                            msg:
                                " Le comptage dans cette zone a été clôturé. Voulez vous le réouvrir ?");
                      } else {
                        bienvenuePageState.setState(() {
                          bienvenuePageState.screenWelcome = 6;
                          bienvenuePageState.running
                              .add(bienvenuePageState.lastLocalite.id);
                        });
                      }
                    });
                  }
                },
                child: Container(
                  height: size.height * .07,
                  width: size.width * .6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/demarer_scan.png'))),
                ),
              ),
            )
          : Positioned(
              top: size.height * .78,
              left: size.width * .2,
              child: GestureDetector(
                onTap: () {
                  if (bienvenuePageState.lastLocalite.id == '0') {
                    showDialogError(
                        context: context, msg: "Selectionnez une localite");
                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = 3;
                    });
                  } else {
                    print(bienvenuePageState.lastLocalite.id);

                    bienvenuePageState.setState(() {
                      bienvenuePageState.screenWelcome = 5;
                      bienvenuePageState.running
                          .add(bienvenuePageState.lastLocalite.id);
                    });
                  }
                },
                child: Container(
                  height: size.height * .07,
                  width: size.width * .6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/suivant_icon.png'))),
                ),
              )),
      Positioned(
          top: size.height * .89,
          child: Container(
            height: 5,
            width: size.width,
            color: Colors.white,
          )),
      positionedBottumNav(size, 4)
    ],
  );
}
