import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String note;
  final String imageUrl;

  NoteModel({this.id, required this.note, required this.imageUrl});

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      NoteModel(note: json['note'], imageUrl: json['url']);

  toJson() => {'note': note, 'imageUrl': imageUrl};

  factory NoteModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return NoteModel(
        id: document.id, note: data['note'], imageUrl: data['imageUrl']);
  }
}
