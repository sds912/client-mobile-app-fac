import 'package:flutter/material.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/top-navBar.dart';

addImmosNiveauUn(context, Immobilisation immo) {
  Size size = MediaQuery.of(context).size;
  bienvenuePageState.setState(() {
    bienvenuePageState.startScan =false ;
  });
  int screen = immo.code=='' ? 4 : 3;
  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.height,
        decoration: BoxDecoration(color: Colors.white),
      ),
      Positioned(
          top: -size.height * .3,
          right: size.width * .15,
          child: Container(
            height: size.height * .7,
            width: size.width * 1.3,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(size.height)),
          )),
      positionedTopNavbar(size),
      Positioned(
          top: size.height * .07,
          left: size.width * .2,
          child: Container(
            height: size.height * .24,
            width: size.width * .6,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo_top_bar.png'),
                    fit: BoxFit.contain)),
          )),
      Positioned(
          top: size.height * .21,
          child: Container(
            height: size.height * .15,
            width: size.width,
            // color: Colors.green,
            child: Center(
              child: Text(
                'Ajouter une nouvelle \n immobilisation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
            ),
          )),
      Positioned(
          top: size.height * .39,
          child: Container(
            height: size.height * .5,
            width: size.width,
            // color: Colors.blue,
            child: Center(
              child: Container(
                width: size.width * .8,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    // Container(
                    //   height: 45,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: Colors.grey[300],
                    //   ),
                    //   child: TextField(
                    //     textAlign: TextAlign.center,
                    //     onChanged: (String value) {
                    //       bienvenuePageState.setState(() {
                    //         bienvenuePageState.immo.libelle = value;
                    //       });
                    //     },
                    //     readOnly: true,
                    //     decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         disabledBorder: InputBorder.none,
                    //         hintText: immo.code == ""
                    //             ? " CODE : AZSZEZSDEFDZZ"
                    //             : " CODE : " + immo.code,
                    //         hintStyle:
                    //             TextStyle(fontSize: 16, color: Colors.black)),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 30.0,
                    // ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onSubmitted: (t) {
                            FocusScope.of(context).nextFocus();
                        },
                        onChanged: (String value) {
                          bienvenuePageState.setState(() {
                            bienvenuePageState.immo.libelle = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText:
                                immo.libelle == "" ? "Libellé" : immo.libelle,
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onSubmitted: (t) {
                            FocusScope.of(context).nextFocus();
                        },
                        onChanged: (String value) {
                          bienvenuePageState.setState(() {
                            bienvenuePageState.immo.description = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: immo.description == ''
                                ? "Description"
                                : immo.description,
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300]),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onSubmitted: (t) {
                            FocusScope.of(context).unfocus();
                        },
                        onChanged: (String value) {
                          bienvenuePageState.setState(() {
                            bienvenuePageState.immo.commentaire = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: immo.commentaire == ''
                                ? "Commentaire"
                                : immo.commentaire,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                      child: GestureDetector(
                        onTap: () {
                          bienvenuePageState.setState(() {
                            bienvenuePageState.screenWelcome = 7;
                          });
                        },
                        child: Container(
                          height: 56.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/suivant_icon.png')),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
                  ],
                ),
              ),
            ),
          )),
      positionedBottumNav(size, screen)
    ],
  );
}
