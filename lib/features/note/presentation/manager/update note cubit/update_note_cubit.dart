import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/constants.dart';
part 'update_note_state.dart';

class UpdateNoteCubit extends Cubit<UpdateNoteState> {
  UpdateNoteCubit() : super(UpdateNoteInitial());
  String? mainPath;
  String? branchPath;
  String? oldNote;
  late TextEditingController note;
  updateNote() async {
    CollectionReference categories =
        FirebaseFirestore.instance.collection(firstCollection);
    try {
      emit(UpdateNoteLoading());
      await categories
          .doc(mainPath)
          .collection(noteCollection)
          .doc(branchPath)
          .update({"note": note.text});
      emit(UpdateNoteSuccess(successMessage: 'Updating Note successfully'));
    } catch (e) {
      emit(UpdateNoteFailure(errorMessage: e.toString()));
    }
  }
}
