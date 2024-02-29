import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(PickImageInitial());

  File? file;
  final ImagePicker picker = ImagePicker();
  String? baseName;
  pickImage() async {
    try {
      emit(PickImageLoading());
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        file = File(image.path);
        baseName = p.basename(image.path);
        emit(PickImageSuccess());
      }
    } catch (e) {
      emit(PickImageFailure(errorMessage: e.toString()));
    }
  }

  captureImage() async {
    try {
      emit(PickImageLoading());
      // Capture a photo.
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        file = File(photo.path);
        emit(PickImageSuccess());
        baseName = p.basename(photo.path);
      }
    } catch (e) {
      emit(PickImageFailure(errorMessage: e.toString()));
    }
  }
}
