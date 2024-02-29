import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_training/core/constants.dart';
import 'package:firebase_training/features/note/data/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());
  late String mainPath;
  CollectionReference categories =
      FirebaseFirestore.instance.collection(firstCollection);
  late CollectionReference notes;
  addNote({required NoteModel note}) async {
    // Call the user's CollectionReference to add a new note
    try {
      emit(AddNoteLoading());
      notes = categories.doc(mainPath).collection(noteCollection);
      DocumentReference response = await notes.add(note.toJson());
      emit(AddNoteSuccess(
          successMessage: 'Adding successfully Note : $response'));
    } catch (e) {
      emit(AddNoteFailure(error: '$e'));
    }
  }
}
