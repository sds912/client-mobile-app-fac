import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1/pages/bienvenue.dart';
import 'package:v1/utils/send-mail.dart';

Future writeFileExportJson(String nameFichier) async =>
    SharedPreferences.getInstance().then((prefs) async {
      Directory dir = await getExternalStorageDirectory();

      File file = File('${dir.path}/$nameFichier.json');

      bienvenuePageState.setState(() {
        bienvenuePageState.file = file;
      });

      if (prefs.getString('inventaireExport') == null) {
        file
            .writeAsString(
                '{"inventaire" : { "id" : 0 , "immos" : [] , "token" : "" , "localite" : []}}')
            .then((f) => f.create(recursive: true).then((f1) => sendEmail(f,nameFichier)));
      } else {
        file
            .writeAsString(prefs.getString("inventaireExport"))
            .then((f) => f.create(recursive: true).then((f1) => sendEmail(f1,nameFichier)));
      }
    });
