import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/web.dart';
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
                  width: 40.0,
                  height: 40.0,
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
          height: fontSize <= 14.0 ? 100.0 : 200.0,
          width: 250.0,
          child: Column(
            children: [
              Container(
                height: fontSize <= 14.0 ? 50.0 : 75.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/alert_info.png'))),
              ),
              SizedBox(
                height: 5.0,
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

showDialogErrorByTakeTofOrStatus(
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
                  width: 40.0,
                  height: 40.0,
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
          height: fontSize <= 14.0 ? 100.0 : 200.0,
          width: 250.0,
          child: Column(
            children: [
              Container(
                height: fontSize <= 14.0 ? 35.0 : 75.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/icon_info_color.png'))),
              ),
              Container(
                height: 60.0,
                child: Text(
                  msg,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.averiaSansLibre(fontSize: fontSize),
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
            ],
          ),
        ),
      ));
}

showDialogErrorSuccess(
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
                  width: 40.0,
                  height: 40.0,
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
                  width: 40.0,
                  height: 40.0,
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
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Container(
                width: 72.0,
                height: 32.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/non.png') , fit: BoxFit.contain)),
              ),
            ),
          ),
          SizedBox(
            width: 40.0,
          ),
          GestureDetector(
            // color: Colors.orange[700],
            onTap: () {
              setCloseComptageZone(bienvenuePageState.lastLocalite)
                  .then((verif) {
                if (verif) {
                  sendDataRealTime();
                  bienvenuePageState.setState(() {
                    deleteImmobilisationsList().then((value) => bienvenuePageState.immos_scanne = [])
                    ;
                    bienvenuePageState.screenWelcome = 3;
                    bienvenuePageState.closing
                        .add(bienvenuePageState.lastLocalite.id);
                    setListIdClose(
                        bienvenuePageState.lastLocalite.id.toString());
                    Navigator.pop(context);
                    showDialogError(
                        context: context,
                        msg:
                            'Vous avez fermé le comptage  de cette zone : ${bienvenuePageState.lastLocalite.nom}');
                  });
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Container(
                width: 72.0,
                height: 32.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/oui.png'),
                      fit: BoxFit.contain),
                  // color: Colors.red
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
        content: Container(
          height: 100,
          width: 250.0,
          // color: Colors.red,
          child: Column(
            children: [
              Container(
                height: 55.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/alert_info.png') , fit: BoxFit.contain)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height:  20.0 ,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/text_cloture.png') , fit: BoxFit.contain)
                ),
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
                  width: 40.0,
                  height: 40.0,
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
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Container(
                width: 72.0,
                height: 32.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/non.png') , fit: BoxFit.contain)),
              ),
            ),
          ),
          SizedBox(
            width: 40.0,
          ),
          GestureDetector(
            // color: Colors.orange[700],
            onTap: () =>
                getCloseComptageZone(bienvenuePageState.lastLocalite)
                    .then((verif) {
              if (verif) {
                bienvenuePageState.setState(() {
                  bienvenuePageState.screenWelcome = 11;
                  Navigator.pop(context);
                });
              }
            }),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Container(
                width: 72.0,
                height: 32.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/oui.png'),
                      fit: BoxFit.contain),
                  // color: Colors.red
                ),
              ),
            ),
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
                height: 60.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/alert_info.png'))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 12),
                child: Container(
                  height: fontSize <= 14.0 ? 32.0 : 32.0,
                  child: Center(
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.averiaSansLibre(fontSize: fontSize , wordSpacing: 0),
                    ),
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

showDialogParams({BuildContext context}) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(0.0),
            title: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/close_dialog.png'),
                              fit: BoxFit.contain)),
                    ),
                  ],
                ),
              ),
            ),
            content: Container(
              height: 130,
              width: 300,
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      width: 300,
                    ),
                    Positioned(
                      top: 15,
                      child: Container(
                        height: 35,
                        // color: Colors.red,
                        width: 300,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Etat du Bien :   ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ToggleSwitch(
                              fontSize: 12.0,
                              cornerRadius: 5,
                              minHeight: 20,
                              // icons: [Icons.settings],
                              initialLabelIndex:
                                  bienvenuePageState.etat_du_bien ? 0 : 1,
                              activeBgColor: Colors.orange[700],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.grey[900],
                              labels: ['Bon', 'Mauvais'],
                              onToggle: (index) {
                                bienvenuePageState.setState(() {
                                  bienvenuePageState.etat_du_bien = index == 0;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 65,
                      child: Container(
                        height: 35,
                        child: Container(
                          height: 35,
                          // color: Colors.red,
                          width: 300,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Prise de photo:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ToggleSwitch(
                                fontSize: 12.0,
                                cornerRadius: 5,
                                minHeight: 20,
                                // icons: [Icons.settings],
                                initialLabelIndex:
                                    bienvenuePageState.take_picture ? 0 : 1,
                                activeBgColor: Colors.orange[700],
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.grey[900],
                                labels: ['Oui', 'Non'],
                                onToggle: (index) {
                                  bienvenuePageState.setState(() {
                                    bienvenuePageState.take_picture =
                                        index == 0;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
    });
