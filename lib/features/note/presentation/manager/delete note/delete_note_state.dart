part of 'delete_note_cubit.dart';

@immutable
sealed class DeleteNoteState {}

final class DeleteNoteInitial extends DeleteNoteState {}

final class DeleteNoteLoading extends DeleteNoteState {}

final class DeleteNoteSuccess extends DeleteNoteState {
  final String successMessage;

  DeleteNoteSuccess({required this.successMessage});
}

final class DeleteNoteFailure extends DeleteNoteState {
  final String errorMessage;

  DeleteNoteFailure({required this.errorMessage});
}
