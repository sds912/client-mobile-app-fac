decodeMatricule(String mat) {
  String password = mat.split('MAT-')[1];


  String new_password = '';

  for (var i = 0; i < password.length; i = i + 2) {
    new_password = new_password +
        getChar(password[i].toLowerCase() + password[i + 1].toLowerCase());
  }

  return new_password ;
}

getChar(String e) {
  switch (e) {
    case '00':
      return 'a';
      break;
    case '01':
      return 'b';
      break;
    case '02':
      return 'c';
      break;
    case '03':
      return 'd';
      break;
    case '04':
      return 'e';
      break;
    case '05':
      return 'f';
      break;
    case '06':
      return 'g';
      break;
    case '07':
      return 'h';
      break;
    case '08':
      return 'i';
      break;
    case '09':
      return 'j';
      break;
    case '10':
      return 'k';
      break;
    case '11':
      return 'l';
      break;
    case '12':
      return 'm';
      break;
    case '13':
      return 'n';
      break;
    case '14':
      return 'o';
      break;
    case '15':
      return 'p';
      break;
    case '16':
      return 'q';
      break;
    case '17':
      return 'r';
      break;
    case '18':
      return 's';
      break;
    case '19':
      return 't';
      break;
    case '20':
      return 'u';
      break;
    case '21':
      return 'v';
      break;
    case '22':
      return 'w';
      break;
    case '23':
      return 'x';
      break;
    case '24':
      return 'y';
      break;
    case '25':
      return 'z';
      break;
    case 'zz':
      return '0';
      break;
    case 'yy':
      return '1';
      break;
    case 'xx':
      return '2';
      break;
    case 'ww':
      return '3';
      break;
    case 'vv':
      return '4';
      break;
    case 'uu':
      return '5';
      break;
    case 'tt':
      return '6';
      break;
    case 'ss':
      return '7';
      break;
    case 'rr':
      return '8';
      break;
    case 'qq':
      return '9';
      break;
    default:
      return e[0];
  }
}
