import 'package:flutter/material.dart';
import 'package:v1/utils/upload-file.dart';

uploadFile(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_color.png'),
                fit: BoxFit.cover)),
      ),
      Positioned(
          top: size.height * .1,
          right: -size.width * .15,
          child: Container(
            height: size.height * .8,
            width: size.width * 1.5,
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(size.height)),
          )),
      Positioned(
          top: size.height * .25,
          left: size.width * .2,
          child: Container(
            height: size.height * .24,
            width: size.width * .6,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo_top_bar.png'))),
          )),
      Positioned(
          top: size.height * .45,
          left: size.width * .1,
          child: Container(
            height: size.height * .09,
            width: size.width * .8,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/text_telecharger.png'))),
          )),
      Positioned(
          top: size.height * .59,
          left: size.width * .34,
          child: GestureDetector(
            onTap: () => getFile(),
            child: Container(
              height: size.height * .1,
              width: size.width * .32,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/icon_telechargement.png'))),
            ),
          )),
      Positioned(
          top: size.height * .73,
          left: size.width * .15,
          child: GestureDetector(
            onTap: () => getFile(),
            child: Container(
              height: size.height * .08,
              width: size.width * .7,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/telecharger_icon.png')),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          )),
    ],
  );
}
