import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'upload_image_state.dart';

class UploudImageCubit extends Cubit<UploudImageState> {
  UploudImageCubit() : super(UploudImageInitial());

  String? url;
  uploadAndDowload({required File file, required String baseName}) async {
    try {
      emit(UploudImageLoading());
      final refImage = FirebaseStorage.instance.ref("images").child(baseName);
      await refImage.putFile(file);
      url = await refImage.getDownloadURL();
      emit(UploudImageSuccess());
    } catch (e) {
      emit(UploudImageFailure(errorMessage: e.toString()));
    }
  }
}
