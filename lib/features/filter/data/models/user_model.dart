//import 'package:json_annotation/json_annotation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String documentId;
  final String name;
  final num age;
  final num money;

  UserModel(
      {required this.documentId,
      required this.name,
      required this.age,
      required this.money});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'],
      age: json['age'],
      money: json['money'],
      documentId: json['documentId']);

  Map<String, dynamic> toJson() => {'name': name, 'age': age, 'money': money};

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        documentId: document.id,
        name: data['name'],
        age: data['age'],
        money: data['money']);
  }

  /* UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        name = snapshot['name'],
        age= snapshot['creationTimestamp'],
        ratings = List.from(snapshot['ratings']),
        players = List.from(snapshot['players']),
        gameReview = GameReview.fromMap(snapshot['gameReview']);*/
}
