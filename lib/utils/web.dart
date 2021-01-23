import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/shared-preference.dart';

//const base_url = 'http://back-test.inventaire.asma-technologies.fr/api'; //ENLEVER LES SS
const base_url = 'http://65b6205776a7.ngrok.io/api';

verifIfApiIsAvailable() async {
  return http.get(base_url).then(((req) async {
    print(req.statusCode);
    if (req.statusCode == 200) {  
      return true;
    } else {
      return false;
    }
  }));
}

class UtilsHttp {
  static postByIssa(endPoint, body) {
    String url = base_url + endPoint;

    Dio dio = new Dio();
    return SharedPreferences.getInstance().then((prefs) {
      return dio
          .post(url,
              data: body,
              options: Options(contentType: "application/json", headers: {
                HttpHeaders.ACCEPT: "application/json",
                HttpHeaders.AUTHORIZATION: "Bearer ${prefs.getString('token')}"
              }))
          .then((success) => success);
    });
  }

  static getByIssa(endPoint) {
    String url = base_url + endPoint;

    Dio dio = new Dio();
    return SharedPreferences.getInstance().then((prefs) {
      return dio
          .get(url,
              options: Options(contentType: "application/json", headers: {
                HttpHeaders.ACCEPT: "application/json",
                HttpHeaders.AUTHORIZATION: "Bearer ${prefs.getString('token')}"
              }))
          .then((success) => success);
    });
  }
}



sendDataRealTime() async {


  
  saveImmosHistory(bienvenuePageState.immos_scanne);
  getImmobilisationFileJson().then((immos) async {

    print('sending ${immos.toString()}');

    String localites = '';
    String running = '';
    String close = '';

   localites =  await getAllNewLOcaliteJson();

    int irun = 0;
    
    int iclose = 0;


    for (var item in bienvenuePageState.running) {
      if (irun == 0) {
        running = item;
      } else {
        running+=','+item;
      }
      irun++;
    }

    for (var item in bienvenuePageState.closing) {
      if (iclose == 0) {
        close = item;
      } else {
        close+=','+item;
      }
      iclose++;
    }

    var str =
        '{ "inventaire" :{ "close" : [$close], "begin" : [$running]  ,"id" : ${bienvenuePageState.inventaire.id} , "immos" : [${immos}]  , "token" : "${bienvenuePageState.imei}-${bienvenuePageState.inventaire.id}"  , "localites":[$localites] ,"idCE" : "${bienvenuePageState.user.id}"  }}';

    UtilsHttp.postByIssa('/mobile/data', str).then((value) {
      print('value.data => ${value.data}');
      print(value.data['code'] == 200);
    });
  
  });
}



realTimeSender(immo) async {
   String localites = '';
    String running = '';
    String close = '';

     localites =  await getAllNewLOcaliteJson();

      int irun = 0;
    
    int iclose = 0;


    for (var item in bienvenuePageState.running) {
      if (irun == 0) {
        running = item;
      } else {
        running+=','+item;
      }
      irun++;
    }

    for (var item in bienvenuePageState.closing) {
      if (iclose == 0) {
        close = item;
      } else {
        close+=','+item;
      }
      iclose++;
    }

  var immos = [];

 var im = '';
      if (immo.image == '') {
        im = '';
      } else {
        im = 'data:image/jpeg;base64,${immo.image}';
      }



  var str =
          '{"id" : ${immo.id}  , "libelle" : "${immo.libelle}" , "code" : "${immo.code}" , "emplacement" :"${immo.emplacement}" , "description":"${immo.description}", "etat" : "${immo.etat}" , "image" : "$im", "status" : ${immo.status} , "lecteur" : ${bienvenuePageState.user.id} , "date" : "${DateTime.now()}" }';
 
    immos.add(str);
   var data =
        '{ "inventaire" :{ "close" : [$close], "begin" : [$running]  ,"id" : ${bienvenuePageState.inventaire.id} , "immos" : [$str]  , "token" : "${bienvenuePageState.imei}-${bienvenuePageState.inventaire.id}"  , "localites":[$localites] ,"idCE" : "${bienvenuePageState.user.id}"  }}';

  /*

   UtilsHttp.postByIssa('/mobile/data', data).then((value) {
      print('value.data => ${value.data}');
      print(value.data['code'] == 200);
    });

    */

  print('rtm: $data');

}
