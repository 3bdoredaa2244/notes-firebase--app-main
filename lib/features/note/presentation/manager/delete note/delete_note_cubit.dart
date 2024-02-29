import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constants.dart';

part 'delete_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit() : super(DeleteNoteInitial());

  deleteNote(String mainPath, String branchPath) async {
    CollectionReference categories =
        FirebaseFirestore.instance.collection(firstCollection);
    try {
      emit(DeleteNoteLoading());
      await categories
          .doc(mainPath)
          .collection(noteCollection)
          .doc(branchPath)
          .delete();
      emit(DeleteNoteSuccess(successMessage: 'deleting note successfully'));
    } catch (e) {
      emit(DeleteNoteFailure(errorMessage: e.toString()));
    }
  }
}
