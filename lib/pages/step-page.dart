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
          top: size.height * .0,
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
        child: Container(
          height: size.height * .15,
          width: size.width,
          child: Stack(
            children: [
              Container(
                height: 50,
                width: 300,
              ),
              Positioned(
                top: 15,
                child: Container(
                  height: 35,
                  // color: Colors.red,
                  width: 300,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => showDialogErrorByTakeTofOrStatus(
                            msg: 'Confirmer l\'etat du bien aprés chaque scan',
                            context: context,
                            fontSize: 12),
                        icon: Container(
                          height: size.height * .3,
                          width: size.width * .3,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/info_icon.png'))),
                        ),
                      ),
                      Text(
                        'Etat du Bien :   ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Switch(
                          value: bienvenuePageState.etat_du_bien,
                          activeColor: Colors.green[700],
                          onChanged: (l) {
                            bienvenuePageState.setState(() {
                              bienvenuePageState.etat_du_bien = l;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 60,
                child: Container(
                  height: 35,
                  child: Container(
                    height: 35,
                    // color: Colors.red,
                    width: 300,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => showDialogErrorByTakeTofOrStatus(
                              msg:
                                  'Prendre une image à chaque fois que vous scanner un bien en mauvais etat ou une nouvelle immobilisation ou une immobilisation non reconciliée',
                              context: context,
                              fontSize: 12),
                          icon: Container(
                            height: size.height * .3,
                            width: size.width * .3,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/info_icon.png'))),
                          ),
                        ),
                        Text(
                          'Prise d\'image:  ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                          child: Switch(
                            value: bienvenuePageState.take_picture,
                            activeColor: Colors.green[700],
                            onChanged: (l) {
                              bienvenuePageState.setState(() {
                                bienvenuePageState.take_picture = l;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
          top: size.height * .32,
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
        top: size.height * .39,
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
                                " Le comptage dans cette localité a été clôturé. Voulez vous le réouvrir ?");
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
