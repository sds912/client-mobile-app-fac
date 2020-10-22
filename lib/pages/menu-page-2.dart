import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/getUserRole.dart';
import 'package:v1/widget/showDialogQuitorDeconect.dart';
import 'package:v1/widget/top-navBar.dart';

menuPageDeux(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
      ),
      Positioned(
          top: -size.height * .15,
          child: Container(
            height: size.height * .5,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .22,
                ),
                Container(
                  height: size.height * .1,
                  width: size.width * .2,
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(size.height),
                      image: DecorationImage(
                          image: AssetImage('assets/images/profile_avatar.jpg'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: size.height * 0.11,
                  width: size.width * .7,
                  // color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        bienvenuePageState.user.nom,
                        style: GoogleFonts.averiaSansLibre(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                      Text(
                        getUserRole(bienvenuePageState.user),
                        style: GoogleFonts.averiaSansLibre(
                            color: Colors.white,
                            fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/menu_background.png'),
                  fit: BoxFit.cover),
            ),
          )),
      positionedTopNavbar(size),
      Positioned(
          top: size.height * .32 + 15,
          left: size.width * .1,
          child: GestureDetector(
            onTap: () {
              bienvenuePageState.setState(() {
                bienvenuePageState.screenWelcome = 11;
              });
            },
            child: Container(
              height: 100,
              width: size.width * .8,
              decoration: BoxDecoration(
                  // color: Colors.green[800],
                  image: DecorationImage(
                      image: AssetImage('assets/images/deveroullez_btn.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
          )),
      Positioned(
          top: size.height * .32 + 100,
          left: size.width * .1,
          child: Container(
            height: 56.0,
            width: size.width * .8,
            child: Center(
              child: Text(
                'Déverrouillez l\'inventaire',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )),
      Positioned(
          top: size.height * .53,
          left: size.width * .1,
          child: GestureDetector(
            onTap: () {
              bienvenuePageState.setState(() {
                bienvenuePageState.screenWelcome = 6;
              });
            },
            child: Container(
              height: 110,
              width: size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.orange[800],
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/liste_des_immobilisations.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
          )),
      Positioned(
          top: size.height * .53 + 105,
          left: size.width * .1,
          child: Container(
            height: 56,
            width: size.width * .35,
            child: Center(
                child: Text(
              'Immobilisations \nscannées',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )),
          )),
      Positioned(
          top: size.height * .53,
          right: size.width * .1,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 110,
              width: size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.orange[800],
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/add_immobilisation_gris.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
          )),
      Positioned(
          top: size.height * .53 + 105,
          right: size.width * .1,
          child: Container(
            height: 56,
            width: size.width * .35,
            child: Center(
                child: Text(
              'Nouvelle \n  immobilisation',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )),
          )),
      Positioned(
          top: size.height * .75,
          left: size.width * .1,
          child: GestureDetector(
            onTap: () {
              print('send mail');
            },
            child: Container(
              height: 110,
              width: size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.orange[800],
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/envoyer_par_mail_gris.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
          )),
      Positioned(
          top: size.height * .75 + 95,
          left: size.width * .1,
          child: Container(
            height: 56,
            width: size.width * .35,
            child: Center(
                child: Text(
              'Envoyer par mail',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )),
          )),
      Positioned(
          top: size.height * .75,
          right: size.width * .1,
          child: GestureDetector(
            onTap: () => showDialogQuitorDeconect(context),
            child: Container(
              height: 110,
              width: size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.orange[800],
                  image: DecorationImage(
                      image: AssetImage('assets/images/deconection.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
          )),
      Positioned(
          top: size.height * .75 + 95,
          right: size.width * .1,
          child: Container(
            height: 56,
            width: size.width * .35,
            child: Center(
                child: Text(
              'Déconnexion',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )),
          )),
    ],
  );
}
