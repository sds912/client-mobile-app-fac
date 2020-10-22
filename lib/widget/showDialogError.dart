import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/shared-preference.dart';
// import 'package:v1/pages/bienvenue.dart';

showDialogError({BuildContext context, String msg, double fontSize = 14.0}) {
  // bienvenuePageState.setState(() {
  //   bienvenuePageState.screenWelcome = 6 ;
  // });
  return showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(0.0),
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
                          fit: BoxFit.cover)),
                ),
              ],
            ),
          ),
        ),
        content: Container(
          height: fontSize <= 14.0 ? 150.0 : 200.0,
          width: 250.0,
          child: Column(
            children: [
              Container(
                height: 75.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/alert_info.png'))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: fontSize <= 14.0 ? 32.0 : 64.0,
                child: Center(
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.averiaSansLibre(fontSize: fontSize),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ));
}

showDialogErrorSuccess({BuildContext context, String msg, double fontSize = 14.0}) {
  // bienvenuePageState.setState(() {
  //   bienvenuePageState.screenWelcome = 6 ;
  // });
  return showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(0.0),
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
                          fit: BoxFit.cover)),
                ),
              ],
            ),
          ),
        ),
        content: Container(
          height: fontSize <= 14.0 ? 150.0 : 200.0,
          width: 250.0,
          child: Column(
            children: [
              Container(
                height: 75.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/success.gif'))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: fontSize <= 14.0 ? 32.0 : 64.0,
                child: Center(
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.averiaSansLibre(fontSize: fontSize),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ));
}

showDialogErrorComptage(
    {BuildContext context, String msg, double fontSize = 14.0}) {
  // bienvenuePageState.setState(() {
  //   bienvenuePageState.screenWelcome = 6 ;
  // });
  return showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(0.0),
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
                          fit: BoxFit.cover)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          RaisedButton(
            color: Colors.grey[200],
            onPressed: () => Navigator.pop(context),
            child: Container(
                width: 64.0, child: Text('Non', textAlign: TextAlign.center)),
          ),
          SizedBox(
            width: 64.0,
          ),
          RaisedButton(
            color: Colors.orange[700],
            onPressed: () =>
                setCloseComptageZone(bienvenuePageState.lastLocalite)
                    .then((verif) {
              if (verif) {
                bienvenuePageState.setState(() {
                  bienvenuePageState.screenWelcome = 3;
                  Navigator.pop(context);
                  showDialogError(
                      context: context,
                      msg:
                          'Vous fermé le comptage  de cette zone : ${bienvenuePageState.lastLocalite.nom}');
                });
              }
            }),
            child: Container(
                width: 64.0,
                child: Text(
                  'Oui',
                  textAlign: TextAlign.center,
                )),
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
        content: Container(
          height: fontSize <= 14.0 ? 150.0 : 200.0,
          width: 250.0,
          child: Column(
            children: [
              Container(
                height: 75.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/alert_info.png'))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: fontSize <= 14.0 ? 32.0 : 64.0,
                child: Center(
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.averiaSansLibre(fontSize: fontSize),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ));
}

showDialogErrorComptageDeblocage(
    {BuildContext context, String msg, double fontSize = 14.0}) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(0.0),
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
                          fit: BoxFit.cover)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          RaisedButton(
            color: Colors.grey[200],
            onPressed: () => Navigator.pop(context),
            child: Container(
                width: 64.0, child: Text('Non', textAlign: TextAlign.center)),
          ),
          SizedBox(
            width: 64.0,
          ),
          RaisedButton(
            color: Colors.orange[700],
            onPressed: () =>
                getCloseComptageZone(bienvenuePageState.lastLocalite)
                    .then((verif) {
              if (verif) {
                bienvenuePageState.setState(() {
                  bienvenuePageState.screenWelcome = 11;
                  Navigator.pop(context);
                });
              }
            }),
            child: Container(
                width: 64.0,
                child: Text(
                  'Oui',
                  textAlign: TextAlign.center,
                )),
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
        content: Container(
          height: fontSize <= 14.0 ? 150.0 : 200.0,
          width: 250.0,
          child: Column(
            children: [
              Container(
                height: 75.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/alert_info.png'))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: fontSize <= 14.0 ? 32.0 : 64.0,
                child: Center(
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.averiaSansLibre(fontSize: fontSize),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ));
}
