import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_training/core/constants.dart';
import 'package:firebase_training/features/note/data/models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'get_note_state.dart';

class GetNoteCubit extends Cubit<GetNoteState> {
  GetNoteCubit() : super(GetNoteInitial());
  late List<NoteModel> notes;
  late String mainPath;
  getNote() async {
    emit(GetNoteLoading());
    notes = [];
    try {
      var response = await FirebaseFirestore.instance
          .collection(firstCollection)
          .doc(mainPath)
          .collection(noteCollection)
          .get();
      response.docs.map((e) => notes.add(NoteModel.fromSnapShot(e)));
      notes = response.docs
          .map((element) => NoteModel.fromSnapShot(element))
          .toList();
      emit(GetNoteSuccess());
    } catch (e) {
      emit(GetNoteFailure(error: e.toString()));
    }
  }
}
