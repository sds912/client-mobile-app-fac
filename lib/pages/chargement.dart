import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

chargementPage(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Stack(children: [
    Container(
      height: size.height,
      width: size.height,
      color: Colors.white,
    ),
    Positioned(
        top: -size.height * .4,
        left: size.width * .2,
        child: Container(
          height: size.height * .95,
          width: size.width * 1.9,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(size.height)),
        )),
    Positioned(
        top: size.height * .32,
        left: size.width * .2,
        child: Container(
          height: size.height * .24,
          width: size.width * .6,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/logo_top_bar.png'))),
        )),
    Positioned(
        top: size.height * .48,
        left: size.width * .34,
        child: Container(
          height: size.height * .1,
          width: size.width * .32,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/gif_chargement2.gif'),
                fit: BoxFit.cover),
          ),
        )),
    Positioned(
        top: size.height * .59,
        child: Container(
          height: size.height * .41,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_oisseaux.png'),
                fit: BoxFit.contain),
          ),
        )),
    Positioned(
        top: size.height * .58,
        left: size.width * .1,
        child: Container(
          height: size.height * .1,
          width: size.width * .8,
          child: Text(
            'Chargement en cours ',
            style: GoogleFonts.averiaSerifLibre(
              fontSize: 14,
              fontWeight: FontWeight.w300
            ),
            textAlign: TextAlign.center,
          ),
        )),
  ]);
}
