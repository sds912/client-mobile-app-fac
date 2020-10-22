import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/widget/bottum-nav.dart';
import 'package:v1/widget/textDetailsImmo.dart';

immobilisationDetails(Immobilisation immo, BuildContext context, bool isTwo) {
  Size size = MediaQuery.of(context).size;

  return Stack(
    children: [
      Container(
        height: size.height,
        width: size.height,
        color: Colors.white,
      ),
      Positioned(
          top: -size.height * .4,
          right: size.width * .1,
          child: Container(
            height: size.height * .8,
            width: size.width * 1.5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(size.height)),
          )),
      Positioned(
          top: 0,
          left: size.width * .2,
          child: Container(
            height: size.height * .14,
            width: size.width * .6,
            decoration: BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
                    image: AssetImage('assets/images/logo_top_bar.png'))),
          )),
      Positioned(
          top: size.height * .12,
          left: size.width * .2,
          child: Container(
            height: size.height * .15,
            width: size.width * .6,
            // color: Colors.red,
            child: Text(
              'Information \nsur l\'immobilisation',
              textAlign: TextAlign.center,
              style: GoogleFonts.averiaSansLibre(
                  fontWeight: FontWeight.w400, fontSize: 26),
            ),
          )),
      Positioned(
          top: size.height * .26,
          left: size.width * .1,
          child: Container(
            height: size.height * .15,
            width: size.width * .8,
            // color: Colors.red,
            child: immo.image == ''
                ? Image.asset('assets/images/no_image.png')
                : Image.memory(
                    base64.decode(immo.image),
                    fit: BoxFit.contain,
                  ),
          )),
      Positioned(
          top: size.height * .44,
          child: Container(
            height: size.height * .42,
            width: size.width,
            child: Column(
              children: [
                textDetailsImmo(
                    context, 'Code : ', immo.code, Colors.grey[200]),
                textDetailsImmo(
                    context, 'Libellé : ', immo.libelle, Colors.grey[50]),
                textDetailsImmo(
                    context,
                    'Commentaire : ',
                    immo.commentaire != null ? immo.commentaire : '',
                    Colors.grey[200]),
                textDetailsImmo(
                    context,
                    'Description : ',
                    immo.description != null ? immo.description : '',
                    Colors.grey[50]),
                textDetailsImmo(context, 'Emplacement : ',
                    immo.emplacement_string, Colors.grey[200]),
                textDetailsImmo(
                    context,
                    'État : ',
                    immo.etat == '1' ? 'Bon État' : 'Mauvais État',
                    Colors.grey[50]),
                textDetailsImmo(
                    context,
                    'Statut : ',
                    immo.status == '0'
                        ? 'Immobilisations scannées non réconciliées'
                        : immo.status == '1'
                            ? 'Immobilisations scannées réconciliées'
                            : immo.status == '2'
                                ? 'Immobilisations rajoutées'
                                : 'Immobilisations avec code défectueux',
                    Colors.grey[200]),
                textDetailsImmo(
                    context, 'Lecteur : ', immo.lecteur, Colors.grey[50]),
                textDetailsImmo(
                    context,
                    'Date inventoriée : ',
                    immo.dateTime.split(' ')[0].split('-')[2] +'/'+immo.dateTime.split(' ')[0].split('-')[1]+'/'+immo.dateTime.split(' ')[0].split('-')[0]+
                        '  \t\t\t ' +
                        immo.dateTime.split(' ')[1].split('.')[0],
                    Colors.grey[200]),
              ],
            ),
          )),
      isTwo ? positionedBottumNav(size, 15) : positionedBottumNav(size, 6),
    ],
  );
}
