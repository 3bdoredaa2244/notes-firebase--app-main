import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_training/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit() : super(SignOutInitial());

  signOut() async {
    try {
      emit(SignOutLoading());
      /*if (googleLogin == true) {
        GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.disconnect();
      }*/
      GoogleSignIn googleSignIn = GoogleSignIn();
      await FirebaseAuth.instance.signOut();

      //await googleSignIn.disconnect();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutFailure(errorMessage: e.toString()));
    }
  }
}
