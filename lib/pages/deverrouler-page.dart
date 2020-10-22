import 'package:flutter/material.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/step/decodeLocalite.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/showDialogError.dart';

deverouillerPage(BuildContext context, Localites ln) {
  Size size = MediaQuery.of(context).size;
  TextEditingController _controller = TextEditingController();
  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.height,
        color: Colors.white,
      ),
      Positioned(
          top: -size.height * .4,
          right: size.width * .1,
          child: Container(
            height: size.height * .8,
            width: size.width * 1.5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(size.height)),
          )),
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
      Positioned(
          top: size.height * .2,
          child: Container(
            height: size.height * .2,
            width: size.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    'Veuillez saisir le code',
                    style: TextStyle(
                        fontSize: 24,
                        wordSpacing: 1.5,
                        letterSpacing: -1.5,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    bienvenuePageState.libelle_localite.length <
                            getIntNiveau(ln.niveau)
                        ? 'pour déverrouillez le ${bienvenuePageState.libelle_localite[getIntNiveau(ln.niveau) - 1]} ${ln.nom}'
                        : 'pour déverrouillez le ${bienvenuePageState.libelle_localite[getIntNiveau(ln.niveau)]} ${ln.nom}',
                    style: TextStyle(
                        fontSize: 24,
                        wordSpacing: 1.5,
                        letterSpacing: -1.5,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )),
      Positioned(
          top: size.height * .35,
          left: size.width * .05,
          child: Container(
              height: size.height * .57,
              width: size.width * .9,
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 72.0,
                  ),
                  Container(
                    height: size.height * .07,
                    width: size.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: size.height * .07,
                          width: size.width * .2,
                          child: TextField(
                            textAlign: TextAlign.center,
                            cursorWidth: 0,
                            // controller: _controller,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onChanged: (String t) {
                              if (t.length <= 3) {
                                bienvenuePageState.setState(() {
                                  bienvenuePageState.textDecodeTextEncode =
                                      t.toUpperCase();
                                });
                                // _controller.value = TextEditingValue(text :bienvenuePageState.textDecodeTextEncode.toUpperCase());
                              }
                            },
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'ABC',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 5,
                          child: Center(
                            child: Text(
                              '|',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * .07,
                          width: size.width * .2,
                          child: TextField(
                            textAlign: TextAlign.center,
                            cursorWidth: 0,
                            // controller: _controller,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            onChanged: (String t) {
                              if (t.length <= 5) {
                                bienvenuePageState.setState(() {
                                  bienvenuePageState.textDecodeResult =
                                      t.toUpperCase();
                                });
                                // _controller.value = TextEditingValue(text :bienvenuePageState.textDecodeTextEncode.toUpperCase());
                              }
                            },
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '14525',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 5,
                          child: Center(
                            child: Text(
                              '|',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * .07,
                          width: size.width * .2,
                          child: TextField(
                            textAlign: TextAlign.center,
                            cursorWidth: 0,
                            // controller: _controller,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            onChanged: (String t) {
                              if (t.length <= 2) {
                                bienvenuePageState.setState(() {
                                  bienvenuePageState.textDecodeRandom =
                                      t.toUpperCase();
                                });
                              }
                            },
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '16',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 5,
                          child: Center(
                            child: Text(
                              '|',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * .07,
                          width: size.width * .2,
                          child: TextField(
                            textAlign: TextAlign.center,
                            cursorWidth: 0,
                            // controller: _controller,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            onChanged: (String t) {
                              if (t.length <= 5) {
                                bienvenuePageState.setState(() {
                                  bienvenuePageState.textDecodeIsValid =
                                      t.toUpperCase();
                                });
                              }
                            },
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '25639',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  SizedBox(
                    height: 128.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      bienvenuePageState.setState(() {
                        bienvenuePageState.texDecodeAffiche =
                            bienvenuePageState.textDecodeTextEncode +
                                '-' +
                                bienvenuePageState.textDecodeResult +
                                '-' +
                                bienvenuePageState.textDecodeRandom +
                                '-' +
                                bienvenuePageState.textDecodeIsValid;
                      });

                      decodeLocalite(
                              "${bienvenuePageState.inventaire.id}-${bienvenuePageState.lastLocalite.id}",
                              bienvenuePageState.texDecodeAffiche)
                          .then((codeVerif) {
                        if (codeVerif) {
                          checkIfCodeExist(bienvenuePageState.texDecodeAffiche)
                              .then((verif) {
                            if (verif) {
                              showDialogError(
                                  context: context, msg: 'Code déjas utilisée');
                            } else {
                              setCodeOpenLocalite(
                                      bienvenuePageState.texDecodeAffiche)
                                  .then((value) {
                                if (value) {
                                  rebuildSetCloseComptageZone(
                                          bienvenuePageState.lastLocalite)
                                      .then((value) {
                                    bienvenuePageState.setState(() {
                                      bienvenuePageState.screenWelcome = 3;
                                    });
                                  });
                                } else {
                                  showDialogError(
                                      context: context,
                                      msg: 'Erreur inscription code');
                                }
                              });
                            }
                          });
                        } else {
                          showDialogError(
                              context: context, msg: 'Code incorrect');
                        }
                      });
                    },
                    child: Container(
                      height: size.height * .07,
                      width: size.width * .6,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/deveroullez_txt.png')),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ],
              ))),
      positionedBottumNav(size, 3)
    ],
  );
}
