import 'package:flutter/material.dart';
import 'package:v1/pages/bienvenue.dart';

Positioned positionedTopNavbar(Size size) {
  return Positioned(
      top: 0,
      child: Container(
        height: size.height * .05,
        width: size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: size.width * .3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo_top_bar.png'),
                      fit: BoxFit.contain)),
            ),
            SizedBox(
              width: size.width * .35,
            ),
            Container(
              width: size.width * .3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        size: 24,
                        color: Colors.orange[700],
                      ),
                      onPressed: () {
                        // ignore: invalid_use_of_protected_member
                        bienvenuePageState.setState(() {
                          bienvenuePageState.screenAide = bienvenuePageState.screenWelcome;
                          bienvenuePageState.screenWelcome = 10;
                        });
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.border_all,
                        size: 24,
                        color: Colors.orange[700],
                      ),
                      onPressed: () {
                        print(bienvenuePageState.isCloseInv);
                        if (bienvenuePageState.isCloseInv) {
                        // ignore: invalid_use_of_protected_member
                          bienvenuePageState.setState(() {
                            bienvenuePageState.screenWelcome = 10;
                          });
                        } else {
                        // ignore: invalid_use_of_protected_member
                          bienvenuePageState.setState(() {
                            bienvenuePageState.screenWelcome = 4;
                          });
                        }
                      }),
                ],
              ),
            )
          ],
        ),
      ));
}
