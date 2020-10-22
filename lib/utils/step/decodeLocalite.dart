import 'package:v1/pages/bienvenue.dart';

tabAZ(index) {
  List<String> tab = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  return tab[index];
}

Future<bool>decodeLocalite(base, k) async {
  int random = int.parse(k.split("-")[2]);

  String textEncode = tabAZ(random) + tabAZ(random + 2) + tabAZ(random + 5);

  double result =
      (int.parse(k.split("-")[1]) - int.parse(base.split("-")[1]) - 9999) / 5;

  bool isValid =
      (int.parse(k.split("-")[3]) - 17) / 4 == int.parse(k.split("-")[1]);

  if (textEncode == k.split("-")[0] && isValid) {
    return result == 1;
    // return result;
  }
  return false;
}

onChangeHandler(String t) {
  if (t.length <= 3) {
    bienvenuePageState.setState(() {
        bienvenuePageState.isTextDecodeTextField = true;
      bienvenuePageState.textDecodeTextEncode = t.toUpperCase();
    });
  } else {
    if (3 < t.length && t.length <= 8) {
      bienvenuePageState.setState(() {
        bienvenuePageState.isTextDecodeTextField = false;
        bienvenuePageState.textDecodeResult = t.substring(3);
      });
    } else {
      if (8 < t.length && t.length <= 10) {
        bienvenuePageState.setState(() {
          bienvenuePageState.isTextDecodeTextField = false;

          bienvenuePageState.textDecodeRandom = t.substring(8);
        });
      } else {
        if (10 < t.length && t.length <= 15) {
          bienvenuePageState.isTextDecodeTextField = false;

          bienvenuePageState.setState(() {
            bienvenuePageState.textDecodeIsValid = t.substring(10);
          });
        }
      }
    }
  }

  bienvenuePageState.setState(() {
    bienvenuePageState.texDecodeAffiche =
        bienvenuePageState.textDecodeTextEncode +
            '-' +
            bienvenuePageState.textDecodeResult +
            '-' +
            bienvenuePageState.textDecodeRandom +
            '-' +
            bienvenuePageState.textDecodeIsValid;
  });
}
