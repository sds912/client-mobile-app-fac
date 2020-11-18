import 'dart:io';

import 'package:flutter/material.dart';
import 'package:v1/models/catalogue.dart';
import 'package:v1/models/entreprise.dart';
import 'package:v1/models/immobilisation.dart';
import 'package:v1/models/inventaire.dart';
import 'package:v1/models/libelle_localite.dart';
import 'package:v1/models/localites.dart';
import 'package:v1/models/users.dart';
// import 'package:v1/pages/add-immo-niveau-une-catalogue.dart';
import 'package:v1/pages/add-immos-niveau-deux.dart';
import 'package:v1/pages/add-immos-niveau-trois.dart';
import 'package:v1/pages/add-immos-niveau-une.dart';
import 'package:v1/pages/add_localite.dart';
import 'package:v1/pages/chargement.dart';
import 'package:v1/pages/choice-entreprise.dart';
import 'package:v1/pages/deverrouler-page.dart';
import 'package:v1/pages/exit.dart';
import 'package:v1/pages/first-page.dart';
import 'package:v1/pages/immo-deja-scanne.dart';
import 'package:v1/pages/immo-etat-du-bien.dart';
import 'package:v1/pages/immobilisation-details.dart';
import 'package:v1/pages/list-immo-menu.dart';
import 'package:v1/pages/list-immos.dart';
import 'package:v1/pages/menu-page-2.dart';
import 'package:v1/pages/menu-page.dart';
import 'package:v1/pages/step-page.dart';
import 'package:v1/pages/upload-file.dart';
import 'package:v1/pages/connection.dart';
import 'package:v1/utils/shared-preference.dart';
// import 'package:imei_plugin/imei_plugin.dart';
import 'package:v1/utils/web.dart';
// import 'package:v1/widget/showDialogError.dart';

_BienvenuePageState bienvenuePageState;

class BienvenuePage extends StatefulWidget {
  @override
  _BienvenuePageState createState() {
    bienvenuePageState = _BienvenuePageState();
    return bienvenuePageState;
  }
}

class _BienvenuePageState extends State<BienvenuePage> {
  bool etat_du_bien = false;

  bool take_picture = true;

  bool isNewVersionOfCode = true;

  List<Widget> listeStepDrowDown = [];

  List<String> running = [];
  List<String> closing = [];

  int taille_libelle = 0;

  bool isTextDecodeTextField = true;

  String textDecodeTextEncode = '';

  String texDecodeAffiche = '';

  String textDecodeResult = '';

  String textDecodeRandom = '';

  String textDecodeIsValid = '';

  bool isTailleLibDiff = true;

  bool isListDRowDown = true;

  String search_immo;

  bool isStartingSearch = true;

  String imei = '';

  bool passwordVisible = false;

  bool startScan = false;

  bool isCloseInv = false;

  bool isWeb = false;

  bool isNewImmo = false;

  String code_inventaire = '1234';

  String code_inventaire_show = '';

  String email = '';

  String password = '';

  int screenWelcome = 0;

  bool isTwo = false;

  File file;

  bool connect = false;

  Inventaire inventaire;

  List<Immobilisation> immos = [];

  List<Catalogue> catalogues = [];

  List<String> catalogue_recherche = [];
  List catalogue_recherche_affichage = [];
  bool shwoCardRechercheCatalogue = true;

  List<Immobilisation> immos_scanne = [];
  List<Immobilisation> immos_scanne_menu = [];

  Immobilisation immobilisation_detail;

  Immobilisation immo = new Immobilisation(
      id: 0,
      libelle: '',
      commentaire: '',
      description: '',
      code: '',
      emplacement: '',
      etat: '');

  bool isImmoHere = false;

  List<User> users = [];

  User user;

  List<LibelleLocalite> libelle_localite = [];

  bool isLastLibelle = false;

  String lastLibelle = '';

  int intLibelle = 1;

  List<Localites> listeLocalites = [];

  List<Localites> listeLocaliteAdd = [];

  String idLocaliteLastAdd;

  String zoneLocaliteAdd = '';

  String subDivisonLocaliteAdd = '';

  Localites lastLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauZero = [];
  Localites niveauZeroLocalite = Localites(id: '0', nom: '', subdivisions: []);

  int showStep = 0;

  List<DropdownMenuItem<Localites>> niveauUn = [];
  Localites niveauUnLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauDeux = [];
  Localites niveauDeuxLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauTrois = [];
  Localites niveauTroisLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauQuatre = [];
  Localites niveauQuatreLocalite =
      Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauCinq = [];
  Localites niveauCinqLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauSix = [];
  Localites niveauSixLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauSept = [];
  Localites niveauSeptLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauHuit = [];
  Localites niveauHUitLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauNeuf = [];
  Localites niveauNeufLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauDix = [];
  Localites niveauDixLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauOnze = [];
  Localites niveauOnzeLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauDouze = [];
  Localites niveauDouzeLocalite = Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauTreize = [];
  Localites niveauTreizeLocalite =
      Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauQuatorze = [];
  Localites niveauQuatorzeLocalite =
      Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Localites>> niveauQuinze = [];
  Localites niveauQuinzeLocalite =
      Localites(id: '0', nom: '', subdivisions: []);

  List<DropdownMenuItem<Entreprise>> entrepriseDropdown = [];

  Entreprise entreprise =
      new Entreprise(id: 0, denomination: '', selected: false);

  showListPage() {
    bienvenuePageState.setState(() {
      bienvenuePageState.screenWelcome = 6;
    });
  }

  showScreen() async {
    // Future.delayed(Duration(milliseconds: 100)).then((value) {
    //   setState(() {
    //     screenWelcome = 0;
    //   });
    // });

    getCloseInventaire().then((verif) => bienvenuePageState.setState(() {
          bienvenuePageState.isCloseInv = verif;
        }));
    getImmobilisationListFile().then((value) => bienvenuePageState.setState(() {
          bienvenuePageState.immos_scanne = value;
        }));

    // await ImeiPlugin.getImei().then((value) => bienvenuePageState.setState(() {
    //       bienvenuePageState.imei = value;
    //     }));

    verifIfApiIsAvailable().then((value) {
      bienvenuePageState.setState(() {
        bienvenuePageState.isWeb = value;
        setState(() {
          screenWelcome = 0;
        });
      });
    });

    getIdLocalite().then((value) => bienvenuePageState.setState(() {
          bienvenuePageState.idLocaliteLastAdd = value;
        }));

    getListLibelleLocalite().then((liste) {
      bienvenuePageState.setState(() {
        bienvenuePageState.libelle_localite.addAll(liste);
        print(bienvenuePageState.libelle_localite);
      });
    });
  }

  cleanEmailPassword() {
    bienvenuePageState.setState(() {
      bienvenuePageState.email = '';
      bienvenuePageState.password = '';
    });
  }

  @override
  void initState() {
    showScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(bienvenuePageState.libelle_localite);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          elevation: 0,
          toolbarHeight: 0.05,
        ),
        // floatingActionButton:  bienvenuePageState.screenWelcome == 6 ? FloatingActionButton(child: Icon(Icons.settings , size: 42,) , onPressed: () => showDialogParams(context: context), backgroundColor: Color.fromRGBO(45, 49, 66,1),) : null,
        body: screenWelcome == 0
            ? firstPage(context)
            : screenWelcome == 1
                ? uploadFile(context)
                : screenWelcome == 2
                    ? connectionPage(context)
                    : screenWelcome == 3
                        ? stepPage(context)
                        : screenWelcome == 4
                            ? menuPage(context)
                            : bienvenuePageState.screenWelcome == 5
                                ? AddniveauUn(
                                    immo: bienvenuePageState.immo)
                                : bienvenuePageState.screenWelcome == 6
                                    ? listImmo(context)
                                    : bienvenuePageState.screenWelcome == 7
                                        ? addImmoNiveauDeux(
                                            context, bienvenuePageState.immo)
                                        : bienvenuePageState.screenWelcome == 8
                                            ? addImmoNiveauTrois(context,
                                                bienvenuePageState.immo)
                                            : bienvenuePageState
                                                        .screenWelcome ==
                                                    -1
                                                ? chargementPage(context)
                                                : bienvenuePageState.screenWelcome ==
                                                        -2
                                                    ? exitPage(context)
                                                    : bienvenuePageState
                                                                .screenWelcome ==
                                                            9
                                                        ? immobilisationDetails(
                                                            immobilisation_detail,
                                                            context,
                                                            bienvenuePageState
                                                                .isTwo)
                                                        : bienvenuePageState
                                                                    .screenWelcome ==
                                                                10
                                                            ? menuPageDeux(
                                                                context)
                                                            : bienvenuePageState
                                                                        .screenWelcome ==
                                                                    11
                                                                ? deverouillerPage(
                                                                    context,
                                                                    bienvenuePageState
                                                                        .lastLocalite)
                                                                : bienvenuePageState
                                                                            .screenWelcome ==
                                                                        12
                                                                    ? addLocalite(
                                                                        context)
                                                                    : bienvenuePageState.screenWelcome ==
                                                                            13
                                                                        ? immoEtatDuBien(
                                                                            context,
                                                                            bienvenuePageState
                                                                                .immo)
                                                                        : bienvenuePageState.screenWelcome ==
                                                                                14
                                                                            ? immoDejaImmobilisation(context,
                                                                                bienvenuePageState.immo)
                                                                            : bienvenuePageState.screenWelcome == 15
                                                                                ? listImmoMenu(context)
                                                                                : bienvenuePageState.screenWelcome == 16
                                                                                    ? choiceEntreprise(context)
                                                                                    : Container());
  }
}
