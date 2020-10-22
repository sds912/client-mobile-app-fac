import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

textDetailsImmo( BuildContext context , String libelle , String text ,Color color) {
  Size size = MediaQuery.of(context).size ;
  return Container(
    height: size.height * .0465,
    width: size.width,
    color: color,
    child: Row(
      children: [
        Container(
          width: size.width * .4,
          child: Padding(
            padding: const EdgeInsets.only(left :16.0),
            child: Text(libelle , textAlign: TextAlign.start , style: GoogleFonts.averiaSerifLibre(
              fontSize: 14 , 
              fontWeight: FontWeight.w400
            ),),
          ),
        ),
        SizedBox(width: size.width *.005,),
        Container(
          width: size.width * .59,
          child: Text(text , style: GoogleFonts.averiaSerifLibre(
            fontSize: 12 , 
            fontWeight: FontWeight.w400
          ),),
        ),
      ],
    ),
  );
}