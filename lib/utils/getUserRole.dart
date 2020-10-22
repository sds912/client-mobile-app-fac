import 'package:v1/models/users.dart';

String getUserRole(User user) {
  switch (user.roles[0].split('ROLE_')[1]) {
    case 'CE' :
      return 'Chef d\'équipe de comptage';
      break;
    case 'MI' :
      return 'Membre équipe de comptage';
      break;
    default:
      return '';
  }
}

bool getUserRoleBool(User user) {
  switch (user.roles[0].split('ROLE_')[1]) {
    case 'CE' :
      return true;
      break;
    case 'MI' :
      return false;
      break;
    default:
      return false;
  }
}