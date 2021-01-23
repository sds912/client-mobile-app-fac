import 'package:flutter/material.dart';
import 'package:v1/widget/bottum-nav.dart';

class AidePage extends StatefulWidget {
  final int screen;

  const AidePage({Key key, this.screen}) : super(key: key);
  @override
  _AidePageState createState() => _AidePageState();
}

class _AidePageState extends State<AidePage> {
  int Screen = -1;
  Size size;

  ScrollController  scrollController = ScrollController();

  @override
  void initState() {
    Screen = widget.screen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print(Screen);
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
            top: size.height * .03,
            left: size.width * .2,
            child: Container(
              height: size.height * .24,
              width: size.width * .6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo_top_bar.png'))),
            )),
        Positioned(
          top: size.height * .3,
          child: Container(
            height: size.height,
            width: size.width,
            color: Colors.transparent,
            child: ListView(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              children: [
                // ACCUEIL
                listeAide(
                    textTitle: '1. ACCEUIL'.toUpperCase(),
                    screen: 0,
                    textBody: 'body du text',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300]),
                // Upload File
                listeAide(
                    textTitle: '2. Fichier d’inventaire '.toUpperCase(),
                    screen: 1,
                    textBody: 'Text Body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[50]),
                // Connexion
                listeAide(
                    textTitle: '3. Connexion'.toUpperCase(),
                    screen: 2,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300]),
                // MENU
                listeAide(
                    textTitle: '4. Menu'.toUpperCase(),
                    screen: 4,
                    textBody: 'text body',
                    url: 'assets/images/background_color.png',
                    color: Colors.grey[50]),
                // Procéder au comptage'
                listeAide(
                    textTitle: '\t\t\t4.1. Procéder au comptage'.toUpperCase(),
                    screen: 3,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300],
                    fontSize: 16,
                    sizeIcon: 22),
                // Choix de la localité à inventorier
                listeAide(
                    textTitle:
                        '\t\t\t\t\t\t\t\t\t\t\t\t   4.1.1. Choix de la localité à inventorier '
                            .toUpperCase(),
                    screen: 5,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[50],
                    fontSize: 12,
                    sizeIcon: 18),
                //  Lecture des codes-barres
                listeAide(
                    textTitle:
                        '\t\t\t\t\t\t\t\t\t\t\t\t   4.1.2. Lecture des codes-barres '
                            .toUpperCase(),
                    screen: 6,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300],
                    fontSize: 12,
                    sizeIcon: 18),
                //  Lecture des codes-barres
                listeAide(
                    textTitle:
                        '\t\t\t\t\t\t\t\t\t\t\t\t   4.1.3. Capture d’images '
                            .toUpperCase(),
                    screen: 7,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300],
                    fontSize: 12,
                    sizeIcon: 18),
                // Clôturer la zone
                listeAide(
                    textTitle:
                        '\t\t\t\t\t\t\t\t\t\t\t\t   4.1.4. Clôturer la zone'
                            .toUpperCase(),
                    screen: 8,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300],
                    fontSize: 12,
                    sizeIcon: 18),
                //  Liste des immobilisations
                listeAide(
                    textTitle:
                        '\t\t\t4.2. Liste des immobilisations'.toUpperCase(),
                    screen: 9,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300],
                    fontSize: 12,
                    sizeIcon: 18),
                // Nouvelle immobilisation
                listeAide(
                    textTitle:
                        '\t\t\t4.3. Nouvelle immobilisation'.toUpperCase(),
                    screen: 10,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300],
                    fontSize: 12,
                    sizeIcon: 18),
                // Envoyer par email
                listeAide(
                    textTitle: '\t\t\t4.4. Envoyer par email'.toUpperCase(),
                    screen: 11,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300],
                    fontSize: 12,
                    sizeIcon: 18),
                // Déconnexion
                listeAide(
                    textTitle: '\t\t\t4.5. Déconnexion'.toUpperCase(),
                    screen: 12,
                    textBody: 'text body',
                    url: 'assets/images/background_step_page.png',
                    color: Colors.grey[300],
                    fontSize: 12,
                    sizeIcon: 18),
                SizedBox(
                  height: size.height * .2,
                )
              ],
            ),
          ),
        ),
        positionedBottumNav(size, widget.screen)
      ],
    );
  }

  listeAide(
      {@required String textTitle,
      @required int screen,
      @required String textBody,
      @required String url,
      @required Color color,
      double fontSize = 18,
      double sizeIcon = 26}) {
    return Column(children: [
      Container(
        height: size.height * .07,
        width: size.width,
        color: Colors.grey[300],
        child: GestureDetector(
          onTap: () {
            setState(() {
              Screen = Screen != widget.screen ?  screen : -1;
            });
          },
           child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textTitle.toUpperCase(),
                  style: TextStyle(fontSize: fontSize),
                ),
                Screen == screen
                    ? Icon(
                        Icons.arrow_circle_down_outlined,
                        size: sizeIcon,
                      )
                    : Icon(
                        Icons.arrow_circle_up_outlined,
                        size: sizeIcon,
                      )
              ],
            ),
          ),
        ),
      ),
      Screen == screen
          ? Container(
              // height: size.height * .7,
              width: size.width,
              child: Row(
                children: [
                  Container(
                      width: size.width * .5,
                      // color: Colors.yellow,
                      child: Text(textBody)),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: size.width * .45,
                    height: size.height * .6,
                    color: Colors.red,
                  )
                ],
              ),
              color: color,
            )
          : Container(),
    ]);
  }
}
