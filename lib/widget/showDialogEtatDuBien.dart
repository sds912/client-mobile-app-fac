import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/shared-preference.dart';

showDialogEtatDuBien(BuildContext context, int status) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(0.0),
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/close_dialog.png'),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
        content: Container(
          height: 200.0,
          width: 250.0,
          child: Column(
            children: [
              Container(
                height: 56.0,
                child: Center(
                  child: Text(
                    'Etat du Bien',
                    style: GoogleFonts.averiaSansLibre(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: GestureDetector(
                  onTap: () async {
                    ImagePicker.pickImage(
                            source: ImageSource.camera,
                            maxHeight: 200,
                            maxWidth: 400)
                        .then((file) async {
                      File compressedFile =
                          await FlutterNativeImage.compressImage(file.path,
                              quality: 80, targetWidth: 400, targetHeight: 200);

                      var bytes = new File(compressedFile.path);
                      var image = bytes.readAsBytesSync();
                      String base64Encode(List<int> image) =>
                          base64.encode(image);
                      bienvenuePageState.setState(() {
                        bienvenuePageState.immo.etat = '0';
                        bienvenuePageState.immo.status = status.toString();
                        bienvenuePageState.immo.dateTime =
                            DateTime.now().toString();
                        bienvenuePageState.immo.image = base64Encode(image);
                        bienvenuePageState.immo.emplacement =
                            bienvenuePageState.lastLocalite.id.toString();
                        bienvenuePageState.immo.emplacement_string =
                            bienvenuePageState.lastLocalite.nom;
                        bienvenuePageState.immos_scanne
                            .add(bienvenuePageState.immo);
                        setImmobilisationListFile(bienvenuePageState.immo);
                        setImmobilisationListFileJson(bienvenuePageState.immo);
                        bienvenuePageState.screenWelcome = 6;
                        Navigator.pop(context);
                      });
                    });
                  },
                  child: Container(
                    height: 56.0,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/mauvaise_etat.png'),
                            fit: BoxFit.contain)),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: GestureDetector(
                  onTap: () => bienvenuePageState.setState(() {
                    bienvenuePageState.immo.etat = '1';
                    bienvenuePageState.immo.status = status.toString();
                    bienvenuePageState.immo.emplacement =
                        bienvenuePageState.lastLocalite.id.toString();
                    bienvenuePageState.immo.emplacement_string =
                        bienvenuePageState.lastLocalite.nom;
                    bienvenuePageState.immo.dateTime =
                        DateTime.now().toString();
                    bienvenuePageState.immos_scanne
                        .add(bienvenuePageState.immo);
                    setImmobilisationListFile(bienvenuePageState.immo);
                    setImmobilisationListFileJson(bienvenuePageState.immo);
                    Future.delayed(Duration(milliseconds: 5000) , () => bienvenuePageState.screenWelcome = 6);
                    Navigator.pop(context);
                  }),
                  child: Container(
                    height: 56.0,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage('assets/images/bon_etat.png'),
                            fit: BoxFit.contain)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}
