import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/utils/text-utils.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/top-navBar.dart';

immoDejaImmobilisation(BuildContext context, Immobilisation immo) {
  print(immo);
  Size size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.height,
        color: Colors.white60,
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
                '${subStringBydiiDejaScan(immo.libelle, 20)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.averiaSansLibre(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )),
      Positioned(
          top: size.height * .36,
          child: Container(
            height: size.height * .52,
            width: size.width,
            // color: Colors.blue,
            child: Center(
              child: Container(
                width: size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 56.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.orange[800],
                          image: DecorationImage(
                              image: AssetImage('assets/images/alert_info.png'),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      height: size.height * .07,
                      width: size.width,
                      // color: Colors.green,
                      child: Center(
                        child: Text(
                          'Immobilisation déja scannée ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.averiaSansLibre(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
      positionedBottumNav(size, 6)
    ],
  );
}
