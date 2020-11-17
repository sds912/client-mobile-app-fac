import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/colors.dart';
import 'package:v1/widget/top-navBar.dart';

addImmosNiveauUnCatalogue(context, Immobilisation immo) {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  Size size = MediaQuery.of(context).size;

  TextEditingController _controller = TextEditingController();
  SystemChannels.textInput.invokeMethod('TextInput.hide');

  return Column(
    children: [
      Container(
        height: size.height * .4,
        width: size.width,
        // color: colorPrimaire,
        child: Stack(
          children: [
            Container(
              height: size.height * .4,
              width: size.width,
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
                top: size.height * .03,
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
                top: size.height * .16,
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
          ],
        ),
      ),
      SimpleAutoCompleteTextField(
        key: key,
        focusNode: FocusNode(canRequestFocus: false),
        clearOnSubmit: true,
        textChanged: (text) => bienvenuePageState.setState(() {
          bienvenuePageState.immo.libelle = text;
        }),
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: immo.libelle == '' ? 'Libelle' : immo.libelle,
            hintStyle: TextStyle(fontSize: 16, color: Colors.black)),
        suggestions: bienvenuePageState.catalogue_recherche,
      ),
      // Container(
      //                 height: 45,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   color: Colors.grey[300],
      //                 ),
      //                 child: SimpleAutoCompleteTextField(
      //                   key: key,
      //                   focusNode: FocusNode(canRequestFocus: false),
      //                   clearOnSubmit: true,
      //                   textChanged: (text) => bienvenuePageState.setState(() {
      //                     bienvenuePageState.immo.libelle = text;
      //                   }),
      //                   decoration: InputDecoration(
      //                       enabledBorder: InputBorder.none,
      //                       focusedBorder: InputBorder.none,
      //                       hintText:
      //                           immo.libelle == '' ? 'Libelle' : immo.libelle,
      //                       hintStyle:
      //                           TextStyle(fontSize: 16, color: Colors.black)),
      //                   suggestions: bienvenuePageState.catalogue_recherche,
      //                 ),
      //               ),
    ],
  );
}

class AddImmosNiveauUnCatalogue extends StatefulWidget {
  final Immobilisation immo;

  const AddImmosNiveauUnCatalogue({Key key, this.immo}) : super(key: key);

  @override
  _AddImmosNiveauUnCatalogueState createState() =>
      _AddImmosNiveauUnCatalogueState();
}

class _AddImmosNiveauUnCatalogueState extends State<AddImmosNiveauUnCatalogue> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: colorPrimaire,
      child: Center(
        child: SimpleAutoCompleteTextField(
          key: key,
          // focusNode: FocusNode(canRequestFocus: false),
          // clearOnSubmit: true,
          textChanged: (text) => bienvenuePageState.setState(() {
            bienvenuePageState.immo.libelle = text;
          }),
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText:
                  widget.immo.libelle == '' ? 'Libelle' : widget.immo.libelle,
              hintStyle: TextStyle(fontSize: 16, color: Colors.black)),
          suggestions: bienvenuePageState.catalogue_recherche,
        ),
      ),
    );
  }
}
