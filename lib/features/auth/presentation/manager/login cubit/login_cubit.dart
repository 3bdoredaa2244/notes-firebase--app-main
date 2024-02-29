import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  validateLogin(
      TextEditingController email, TextEditingController password) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      if (credential.user!.emailVerified) {
        emit(LoginSuccess());
        // Navigator.of(context).pushReplacementNamed("homepage");
      } else {
        emit(LoginFailure(
            errorMessage: 'not verified , you shoud verified it first'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(
            errorMessage:
                'sorry , user-not-found , try again with correct user'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(
            errorMessage: 'wrong-password ! , try enter it correctly'));
      } else {
        emit(LoginFailure(errorMessage: e.toString()));
      }
    }
  }
}
