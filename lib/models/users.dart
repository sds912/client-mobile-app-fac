import 'package:flutter/material.dart';
import 'package:v1/models/entreprise.dart';

class User {
  int id;
  String username;
  List<String> roles;
  String password;
  String nom;
  String status;
  List<Entreprise> entreprisess;
  List<String> localites ;
  User(
      {@required this.id,
      @required this.username,
      @required this.password,
      @required this.roles,
      @required this.status,
      @required this.nom,
      @required this.entreprisess,
      @required this.localites
      });

  static List<User> fromJson(Map<dynamic, dynamic> l) {
    
    List<User> users = [];
    for (var item in l['users']) {
      List<String> rls = [];

      List<Entreprise> entreprise = [];

      List<String> idL = [];
      print(item['idOfMyLoAffectes']);
      for (var it in item['idOfMyLoAffectes']) {
        idL.add(it.toString());
      }

      for (var it in item['roles']) {
        rls.add(it);
      }


      for (var i in item['entreprisess']) {
        entreprise.add(Entreprise(
            id: i['id'], denomination: i['denomination'], selected: true));
      }
      users.add(User(
          id: item['id'],
          username: item['username'],
          password: item['matricule'],
          roles: rls,
          status: item['status'],
          nom: item['nom'],
          entreprisess: entreprise , 
          localites: idL
          ));
    }
    return users;
  }

  static fromJsonOne(dynamic user) {
    List<String> rls = [];

    List<Entreprise> ent = [];

    

    for (var v in user['entreprises']) {
      ent.add(Entreprise(id: v['id'] , denomination: v['denomination'] , selected: false));
    }

    for (var item in user['roles']) {
      rls.add(item.toString());
    }

    return User(id: user['id'], username: user['username'], password: '', roles: rls, status: user['status'], nom: user['nom'], entreprisess: ent , localites: []);
  }

  @override
  String toString() {
    String rls = '';
    for (var item in this.roles) {
      rls += item +'150495';//our date de naiss
    }
    String ent = '';
    for (var item in this.entreprisess) {
      ent += item.id.toString() +'asma'+ item.denomination +'150495'; // rest of my mind
    }

    String idOfLocalite ='';

    for (var item in this.localites) {
      idOfLocalite += item + '150495' ; //our date de naiss
    }

    return '${this.id}chez_joe${this.nom}chez_joe${this.username}chez_joe${this.password}chez_joe${rls}chez_joe${ent}chez_joe${idOfLocalite}';
  }
}
