import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/pages/bienvenue.dart';

showDialogQuitorDeconect(BuildContext context) {
  return showDialog(
      context: context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(0.0),
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/close_dialog.png'),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
        content: Container(
          height: 175.0,
          width: 200.0,
          child: Column(
            children: [
              Container(
                height: 32.0,
                child: Center(
                  child: Text(
                    'Voulez-vous ?',
                    style: GoogleFonts.averiaSansLibre(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () async {
                  Future.delayed(Duration(seconds: 5)).then((value) => exit(0));
                  bienvenuePageState.setState(() {
                    Navigator.pop(context);
                    bienvenuePageState.screenWelcome = -2;
                  });
                },
                child: Container(
                  height: 56.0,
                  width: 190,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/quiter_application.png'))),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () => bienvenuePageState.setState(() {
                  bienvenuePageState.email = '';
                  bienvenuePageState.password = '';
                  bienvenuePageState.screenWelcome = 2;
                  Navigator.pop(context);
                }),
                child: Container(
                  height: 56.0,
                  width: 190,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/changer_session.png'))),
                ),
              ),
            ],
          ),
        ),
      ));
}
