import 'package:firebase_training/core/constants.dart';
import 'package:firebase_training/features/home/data/repos/home_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:meta/meta.dart';
part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.homeRepo) : super(MessageInitial());
  final HomeRepo homeRepo;
  sendMessage() async {
    try {
      emit(MessageLoading());
      var response = await homeRepo.sendMessage(body: {
        "to": deviceToken,
        "notification": {
          "title": "hi",
          "body": "Rich Notification testing (body)",
          "sound": "Tri-tone"
        },
        "data": {"name": "nader sayed abdul qader"}
      });
      response.fold(
          (failure) => emit(MessageFailure(errorMessage: failure.errorMessage)),
          (_) => emit(MessageSuccess()));
      debugPrint(
          '////////////////////////////////////////success//////////////////////////////////////////');
    } catch (e) {
      emit(MessageFailure(errorMessage: e.toString()));
    }
  }
}
