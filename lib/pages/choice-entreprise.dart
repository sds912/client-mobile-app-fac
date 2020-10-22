import 'package:flutter/material.dart';
import 'package:v1/utils/entreprises/choice-entreprise.dart';

choiceEntreprise(BuildContext context) {
  Size size = MediaQuery.of(context).size;
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
      // positionedTopNavbar(size),
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
                'Veuillez choisir l\'entreprise pour débuter ',
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
          left: size.width *.1,
          child: Container(
              height: size.height * .5,
              width: size.width * .8,
              // color: Colors.blue,
              child: Container(
                height: size.height * .48,
                width: size.width * .6,
                // color: Colors.red,
                child: choiceEntrepriseHelper(context),
              ))),
      // positionedBottumNav(size, screen)
    ],
  );
}
