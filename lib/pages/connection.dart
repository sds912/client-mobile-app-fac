import 'package:flutter/material.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/connect-doc.dart';

connectionPage(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  // bienvenuePageState.setState(() {
  //   bienvenuePageState.email ='';
  //   bienvenuePageState.password ='';
  // });
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
                    'Veuillez saisir votre e-mail',
                    style: TextStyle(
                        fontSize: 24,
                        wordSpacing: 1.5,
                        letterSpacing: -1.5,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'et votre mot de passe pour vous',
                    style: TextStyle(
                        fontSize: 24,
                        wordSpacing: 1.5,
                        letterSpacing: -1.5,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'connecter',
                    style: TextStyle(
                        fontSize: 24,
                        wordSpacing: 1.5,
                        letterSpacing: -1.5,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          )),
      Positioned(
          top: size.height * .35,
          child: Container(
              height: size.height * .57,
              width: size.width,
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 72.0,
                  ),
                  Container(
                    height: size.height * .07,
                    width: size.width * .8,
                    child: TextField(
                      textAlign: TextAlign.center,
                      onChanged: (String t) {
                        bienvenuePageState.setState(() {
                          bienvenuePageState.email = t;
                        });
                      },
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "email",
                        hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    height: size.height * .07,
                    width: size.width * .8,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      obscureText: !bienvenuePageState.passwordVisible,
                      onChanged: (String t) {
                        bienvenuePageState.setState(() {
                          bienvenuePageState.password = t;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "mot de passe",
                        hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                        // suffixIcon: IconButton(
                        //     onPressed: () {
                        //       bienvenuePageState.setState(() {
                        //         bienvenuePageState.passwordVisible =
                        //             !bienvenuePageState.passwordVisible;
                        //       });
                        //     },
                        //     icon: Icon(
                        //       !bienvenuePageState.passwordVisible
                        //           ? Icons.visibility
                        //           : Icons.visibility_off,
                        //       size: 18,
                        //       color: Colors.white,
                        //     )),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  GestureDetector(
                    onTap: () => connectDoc(context),
                    child: Container(
                      height: size.height * .07,
                      width: size.width * .6,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/connexion_icon.png')),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ],
              ))),
      Positioned(
        top: size.height * .9,
        child: GestureDetector(
          onTap: () {
            bienvenuePageState.setState(() {
              bienvenuePageState.screenAide = bienvenuePageState.screenWelcome;
              bienvenuePageState.screenWelcome = 10;
            });
          },
          child: Container(
            height: size.height * .07,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/guide_utilisation_buttom.png'),
                    fit: BoxFit.contain)),
          ),
        ),
      ),
    ],
  );
}
