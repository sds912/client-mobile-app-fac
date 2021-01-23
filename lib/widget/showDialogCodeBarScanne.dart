import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/pages/bienvenue.dart';

showDialogCodeBarScanne(BuildContext context) {
  return showDialog(
      context: context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(0.0),
        title: Row(
          children: [
            GestureDetector(
              onTap: () => bienvenuePageState.setState(() {
                Navigator.pop(context);
                bienvenuePageState.screenWelcome = 6 ;
              }),
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
          height: 250.0,
          width: 250.0,
          child: Column(
            children: [
              Container(
                height: 110.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/alert_info.png'))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 32.0,
                child: Center(
                  child: Text(
                    'Code barre déja scanné',
                    style: GoogleFonts.averiaSansLibre(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () async => bienvenuePageState.setState(() {
                  Future.delayed(Duration(milliseconds: 200) , () => bienvenuePageState.screenWelcome = 6 );
                  Navigator.pop(context);
                }),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Container(
                    height: 56.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/continuer_icon.png'))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}
