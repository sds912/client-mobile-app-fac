import 'package:flutter/material.dart';
import 'package:v1/pages/bienvenue.dart';

Positioned positionedBottumNav(Size size, int screen) {
  return Positioned(
      top: size.height * .9,
      child: GestureDetector(
        onTap: () {
          if (bienvenuePageState.isCloseInv) {
            if (bienvenuePageState.screenWelcome == 9) {
              bienvenuePageState.setState(() {
                bienvenuePageState.screenWelcome = 6;
              });
            } else {
              bienvenuePageState.setState(() {
                bienvenuePageState.screenWelcome = 10;
              });
            }
          } else {
            bienvenuePageState.setState(() {
              bienvenuePageState.screenWelcome = screen;
            });
          }
        },
        child: Container(
          height: size.height * .07,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/retourner_icon.png'))),
        ),
      ));
}
