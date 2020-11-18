import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/shared-preference.dart';
import 'package:v1/utils/web.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/top-navBar.dart';
import 'dart:io' as Io;


class AddniveauUn extends StatefulWidget {
  final Immobilisation immo;

  const AddniveauUn({Key key, this.immo}) : super(key: key);

  @override
  _AddniveauUnState createState() => _AddniveauUnState();
}

class _AddniveauUnState extends State<AddniveauUn> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    int screen = widget.immo.code == '' ? 4 : 3;

    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(color: Colors.white),
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
                  'Ajouter une nouvelle \n immobilisation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
              ),
            )),
        Positioned(
            top: size.height * .39,
            child: Container(
              height: size.height * .5,
              width: size.width,
              // color: Colors.blue,
              child: Center(
                child: Container(
                  width: size.width * .8,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        child: SimpleAutoCompleteTextField(
                          key: key,
                          clearOnSubmit: false,
                          textChanged: (text) {
                            bienvenuePageState.setState(() {
                              bienvenuePageState.immo.libelle = text;
                            });
                            // print('bienvenuePageState.immo.libelle => ${bienvenuePageState.immo.libelle }');
                          },
                          textSubmitted: (t) => {
                            bienvenuePageState.setState(() {
                              bienvenuePageState.immo.libelle = t;
                            })
                          },
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: bienvenuePageState.immo.libelle == ''
                                  ? '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tLibelle'
                                  : bienvenuePageState.immo.libelle,
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                          suggestions: bienvenuePageState.catalogue_recherche,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onSubmitted: (t) {
                            FocusScope.of(context).nextFocus();
                          },
                          onChanged: (String value) {
                            bienvenuePageState.setState(() {
                              bienvenuePageState.immo.description = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: widget.immo.description == ''
                                  ? "Description"
                                  : widget.immo.description,
                              hintStyle:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onSubmitted: (t) {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (String value) {
                            bienvenuePageState.setState(() {
                              bienvenuePageState.immo.commentaire = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: widget.immo.commentaire == ''
                                  ? "Commentaire"
                                  : widget.immo.commentaire,
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                        child: GestureDetector(
                          onTap: () {
                            if (!bienvenuePageState.etat_du_bien) {
                              if (bienvenuePageState.immo.code != '') {
                                ImagePicker.pickImage(
                                        source: ImageSource.camera,
                                        maxHeight: 800,
                                        maxWidth: 1200)
                                    .then((file) async {
                                  Io.File compressedFile =
                                      await FlutterNativeImage.compressImage(
                                          file.path,
                                          quality: 80,
                                          percentage: 80,
                                          targetHeight: 800,
                                          targetWidth: 1200);
                                  var bytes = new Io.File(compressedFile.path);
                                  var image = bytes.readAsBytesSync();
                                  String base64Encode(List<int> image) =>
                                      base64.encode(image);
                                    bienvenuePageState.setState(() {
                                  bienvenuePageState.immo.etat = '1';
                                  bienvenuePageState.immo.status = '0';
                                  bienvenuePageState.immo.emplacement =
                                      bienvenuePageState.lastLocalite.id
                                          .toString();
                                  bienvenuePageState.immo.emplacement_string =
                                      bienvenuePageState.lastLocalite.nom;
                                  bienvenuePageState.immo.search_list =
                                      bienvenuePageState.search_immo;
                                  bienvenuePageState.immo.emplacement_string =
                                      bienvenuePageState.lastLocalite.nom;
                                      bienvenuePageState.immo.image = base64Encode(image);
                                  bienvenuePageState.immo.dateTime =
                                      DateTime.now().toString();
                                  bienvenuePageState.immos_scanne
                                      .add(bienvenuePageState.immo);
                                  setImmobilisationListFile(
                                      bienvenuePageState.immo);
                                  setImmobilisationListFileJson(
                                      bienvenuePageState.immo);
                                  bienvenuePageState.screenWelcome = 6;
                                });
                                sendDataRealTime();
                                });

                                
                              } else {
                                bienvenuePageState.setState(() {
                                  bienvenuePageState.immo.etat = '1';
                                  bienvenuePageState.screenWelcome = 8;
                                });
                              }
                            } else {
                              bienvenuePageState.setState(() {
                                bienvenuePageState.screenWelcome = 7;
                              });
                            }
                          },
                          child: Container(
                            height: 56.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/suivant_icon.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      )
                    ],
                  ),
                ),
              ),
            )),
        positionedBottumNav(size, screen),
      ],
    );
  }
}

addImmosNiveauUn(context, Immobilisation immo) {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  Size size = MediaQuery.of(context).size;
  bienvenuePageState.setState(() {
    bienvenuePageState.startScan = false;
  });
  int screen = immo.code == '' ? 4 : 3;
  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.height,
        decoration: BoxDecoration(color: Colors.white),
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
                'Ajouter une nouvelle \n immobilisation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
            ),
          )),
      Positioned(
          top: size.height * .39,
          child: Container(
            height: size.height * .5,
            width: size.width,
            // color: Colors.blue,
            child: Center(
              child: Container(
                width: size.width * .8,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: SimpleAutoCompleteTextField(
                        key: key,
                        clearOnSubmit: true,
                        textChanged: (text) => bienvenuePageState.setState(() {
                          bienvenuePageState.immo.libelle = text;
                        }),
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText:
                                immo.libelle == '' ? 'Libelle' : immo.libelle,
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        suggestions: bienvenuePageState.catalogue_recherche,
                      ),
                    ),
                    // Container(
                    //   height: 45,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: Colors.grey[300],
                    //   ),
                    //   child: TextField(
                    //     textAlign: TextAlign.center,
                    //     onSubmitted: (t) {
                    //       FocusScope.of(context).nextFocus();
                    //       bienvenuePageState.setState(() {
                    //         bienvenuePageState.shwoCardRechercheCatalogue = false;
                    //       });
                    //     },
                    //     onChanged: (String value) {
                    //       bienvenuePageState.setState(() {
                    //         bienvenuePageState.immo.libelle = value;
                    //         print(bienvenuePageState.immo.libelle);
                    //         bienvenuePageState.shwoCardRechercheCatalogue = true;
                    //       });
                    //       searchBydii(value, bienvenuePageState.catalogue_recherche);
                    //     },

                    //     decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         disabledBorder: InputBorder.none,
                    //         hintText:
                    //             bienvenuePageState.immo.libelle == "" ? "Libellé" : bienvenuePageState.immo.libelle,
                    //         hintStyle:
                    //             TextStyle(fontSize: 16, color: Colors.black)),
                    //   ),
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onSubmitted: (t) {
                          FocusScope.of(context).nextFocus();
                        },
                        onChanged: (String value) {
                          bienvenuePageState.setState(() {
                            bienvenuePageState.immo.description = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: immo.description == ''
                                ? "Description"
                                : immo.description,
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300]),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onSubmitted: (t) {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (String value) {
                          bienvenuePageState.setState(() {
                            bienvenuePageState.immo.commentaire = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: immo.commentaire == ''
                                ? "Commentaire"
                                : immo.commentaire,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                      child: GestureDetector(
                        onTap: () {
                          if (!bienvenuePageState.etat_du_bien) {
                            if (bienvenuePageState.immo.code != '') {
                              bienvenuePageState.setState(() {
                                bienvenuePageState.immo.etat = '1';
                                bienvenuePageState.immo.status = '0';
                                bienvenuePageState.immo.emplacement =
                                    bienvenuePageState.lastLocalite.id
                                        .toString();
                                bienvenuePageState.immo.emplacement_string =
                                    bienvenuePageState.lastLocalite.nom;
                                bienvenuePageState.immo.search_list =
                                    bienvenuePageState.search_immo;
                                bienvenuePageState.immo.emplacement_string =
                                    bienvenuePageState.lastLocalite.nom;
                                bienvenuePageState.immo.dateTime =
                                    DateTime.now().toString();
                                bienvenuePageState.immos_scanne
                                    .add(bienvenuePageState.immo);
                                setImmobilisationListFile(
                                    bienvenuePageState.immo);
                                setImmobilisationListFileJson(
                                    bienvenuePageState.immo);
                                bienvenuePageState.screenWelcome = 6;
                              });
                              sendDataRealTime();
                            } else {
                              bienvenuePageState.setState(() {
                                bienvenuePageState.immo.etat = '1';
                                bienvenuePageState.screenWelcome = 8;
                              });
                            }
                          } else {
                            bienvenuePageState.setState(() {
                              bienvenuePageState.screenWelcome = 7;
                            });
                          }
                        },
                        child: Container(
                          height: 56.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/suivant_icon.png')),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    )
                  ],
                ),
              ),
            ),
          )),
      positionedBottumNav(size, screen),
      // bienvenuePageState.shwoCardRechercheCatalogue ? Positioned(
      //   top: size.height * .45,
      //   left: size.width * .25,
      //   child: Card(

      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //     child: Container(
      //       height: size.height * .2,
      //       width: size.width * .5,
      //       child: ListView(
      //         children: listSelected(bienvenuePageState.catalogue_recherche_affichage),
      //         physics: BouncingScrollPhysics(),
      //       ),
      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      //     ),
      //   ),
      // ) : Container(),
    ],
  );
}

listSelected(List l) {
  List<Widget> li = [];
  // print(l);
  for (var item in l) {
    li.add(GestureDetector(
        onTap: () {
          bienvenuePageState.setState(() {
            bienvenuePageState.immo.libelle = item;
            // bienvenuePageState.shwoCardRechercheCatalogue = false ;
          });
        },
        child: Container(
            height: 45, width: 50, child: Center(child: Text(item)))));
  }
  return li;
}

searchBydii(String str, List liste) {
  List<String> new_list = [];

  for (var item in liste) {
    if (item.toString().toLowerCase().contains(str.toLowerCase())) {
      new_list.add(item);
    }
  }

  bienvenuePageState.setState(() {
    bienvenuePageState.catalogue_recherche_affichage = new_list;
  });
}
