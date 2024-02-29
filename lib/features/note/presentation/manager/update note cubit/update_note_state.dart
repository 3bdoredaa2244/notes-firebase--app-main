part of 'update_note_cubit.dart';

@immutable
sealed class UpdateNoteState {}

final class UpdateNoteInitial extends UpdateNoteState {}

final class UpdateNoteLoading extends UpdateNoteState {}

final class UpdateNoteSuccess extends UpdateNoteState {
  final String successMessage;

  UpdateNoteSuccess({required this.successMessage});
}

final class UpdateNoteFailure extends UpdateNoteState {
  final String errorMessage;

  UpdateNoteFailure({required this.errorMessage});
}
