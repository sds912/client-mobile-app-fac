import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/text-utils.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/top-navBar.dart';
import 'dart:io' as Io;

immoEtatDuBien(BuildContext context, Immobilisation immo) {
  Size size = MediaQuery.of(context).size;
  final ImagePicker picker = ImagePicker();
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
                'Etat de l\'immobilisation \n ${subStringBydii(immo.libelle, 20)}',
                textAlign: TextAlign.center,
                style: TextStyle(
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
                      width: size.width,
                      child: Center(
                        child: Text(
                          'Merci de préciser l\'état du bien.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        bienvenuePageState.setState(() {
                          bienvenuePageState.immo.etat = '1';
                          bienvenuePageState.immo.status = '1';
                          bienvenuePageState.immo.emplacement =
                              bienvenuePageState.lastLocalite.id.toString();
                          bienvenuePageState.immo.emplacement_string =
                              bienvenuePageState.lastLocalite.nom;
                          bienvenuePageState.immo.search_list =
                              bienvenuePageState.search_immo;
                          bienvenuePageState.immo.dateTime =
                              DateTime.now().toString();
                          bienvenuePageState.immos_scanne
                              .add(bienvenuePageState.immo);
                          setImmobilisationListFile(bienvenuePageState.immo);
                          setImmobilisationListFileJson(
                              bienvenuePageState.immo);
                          bienvenuePageState.screenWelcome = 6;
                        });
                      },
                      child: Container(
                        height: 56.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.orange[800],
                            image: DecorationImage(
                                image: AssetImage('assets/images/bon_etat.png'),
                                fit: BoxFit.contain)),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    GestureDetector(
                      onTap: () async {
                        ImagePicker.pickImage(
                                source: ImageSource.camera,
                               maxHeight: 800,
                                  maxWidth: 1200)
                            .then((file) async {
                          Io.File compressedFile =
                              await FlutterNativeImage.compressImage(file.path,
                                  quality: 80,
                                  percentage: 80,
                                  targetHeight: 800,
                                  targetWidth: 1200);

                          var bytes = new Io.File(compressedFile.path);
                          var image = bytes.readAsBytesSync();
                          String base64Encode(List<int> image) =>
                              base64.encode(image);
                          bienvenuePageState.setState(() {
                            bienvenuePageState.immo.etat = '0';
                            bienvenuePageState.immo.status = '1';
                            bienvenuePageState.immo.dateTime =
                                DateTime.now().toString();
                            bienvenuePageState.immo.image = base64Encode(image);
                            bienvenuePageState.immo.emplacement =
                                bienvenuePageState.lastLocalite.id.toString();
                            bienvenuePageState.immo.search_list =
                                bienvenuePageState.search_immo;
                            bienvenuePageState.immo.emplacement_string =
                                bienvenuePageState.lastLocalite.nom;
                            bienvenuePageState.immos_scanne
                                .add(bienvenuePageState.immo);
                            setImmobilisationListFile(bienvenuePageState.immo);
                            setImmobilisationListFileJson(
                                bienvenuePageState.immo);
                            bienvenuePageState.screenWelcome = 6;
                          });
                        });
                      },
                      child: Container(
                        height: 56.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/mauvaise_etat.png'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      positionedBottumNav(size, 6)
    ],
  );
}
