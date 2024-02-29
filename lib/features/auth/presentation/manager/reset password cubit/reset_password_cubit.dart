import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  late String email;
  Future resetPassword() async {
    emit(ResetPasswordLoading());
    try {
      if (email.isEmpty) {
        emit(ResetPasswordEmpty());
        return;
      }
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(error: e.toString()));
    }
  }
}
