import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/constants.dart';
part 'update_category_state.dart';

class UpdateCategoryCubit extends Cubit<UpdateCategoryState> {
  UpdateCategoryCubit() : super(UpdateCategoryInitial());
  String? path;
  String? oldName;
  late TextEditingController name;
  updateCategory() async {
    CollectionReference categories =
        FirebaseFirestore.instance.collection(firstCollection);
    try {
      emit(UpdateCategoryLoading());
      await categories.doc(path).update({"name": name.text});
      emit(UpdateCategorySuccess(
          successMessage: 'Updating category successfully'));
    } catch (e) {
      emit(UpdateCategoryFailure(errorMessage: e.toString()));
    }
  }
}
