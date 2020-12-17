import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v1/pages/bienvenue.dart';

firstPage(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.height,
        color: Colors.white,
      ),
      Positioned(
          top: -size.height * 0.13,
          left: size.width * .25,
          child: Container(
            height: size.height * .5,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/img_first_page.png'),
                    fit: BoxFit.cover),
                // color: Colors.red,
                borderRadius: BorderRadius.circular(size.height)),
          )),
      Positioned(
          top: size.height * .47,
          right: size.width * .2,
          child: Container(
            height: size.height * .5,
            width: size.width,
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
          // left: size.width * .1,
          child: Container(
            height: size.height * .1,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bienvenue.png'))),
          )),
      // Positioned(
      //     top: size.height * .57,
      //     left: size.width * .1,
      //     child: Container(
      //       height: size.height * .2,
      //       width: size.width * .8,

      //       // color: Colors.green,
      //       decoration: BoxDecoration(
      //           image: DecorationImage(
      //               image: AssetImage('assets/images/text_bienvenue.png'))),
      //     )),
      Positioned(
          top: size.height * .6,
          left: size.width * .2,
          child: GestureDetector(
            onTap: () {
              if (bienvenuePageState.isWeb) {
                bienvenuePageState.setState(() {
                bienvenuePageState.screenWelcome = 2;
              });
              } else {
                bienvenuePageState.setState(() {
                bienvenuePageState.screenWelcome = 1;
              });
              }
            },
            child: Container(
              height: size.height * .25,
              width: size.width * .6,
              // color: Colors.green,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/suivant_icon.png'))),
            ),
          )),
          // Positioned(
          //   top: size.height * .82,
          //   left: size.width * .1,
          //   child: Container(
          //   height: 56.0,
          //   width: size.width * .8,
          //   decoration: BoxDecoration(
          //     // color: Colors.red,
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/info_text_buttom_home.png')
          //     )
          //   ),
          // )),
          Positioned(
            bottom: -10,
            child: Container(
            height: 56.0,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_bottum_nav.png')
              )
            ),
          ))
    ],
  );
}
