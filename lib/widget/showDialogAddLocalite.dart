import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/pages/bienvenue.dart';

showDialogAddLocalite(BuildContext context) {
  print(bienvenuePageState.niveauZeroLocalite.nom);
  print('suis la ici');
  return showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/close_dialog.png'),
                          fit: BoxFit.contain)),
                ),
              ],
            ),
          ),
        ),
        content: Container(
          height: 100.0,
          width: 250.0,
          child: Column(
            children: [
              Container(
                height: 32.0,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: TextField(
                      textAlign: TextAlign.center,
                      style: GoogleFonts.averiaGruesaLibre(
                          fontSize: 18, color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Présiser le nom de la localité",
                        hintStyle: GoogleFonts.averiaGruesaLibre(
                            fontSize: 18, color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              GestureDetector(
                onTap: () {
                  print('on est la');
                  bienvenuePageState.setState(() {
                  
                  });
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 32.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/suivant_icon.png'))
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
}
