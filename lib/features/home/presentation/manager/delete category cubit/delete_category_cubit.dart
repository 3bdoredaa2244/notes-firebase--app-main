import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constants.dart';

part 'delete_category_state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  DeleteCategoryCubit() : super(DeleteCategoryInitial());

  deleteCategory(String path) async {
    CollectionReference categories =
        FirebaseFirestore.instance.collection(firstCollection);
    try {
      emit(DeleteCategoryLoading());
      await categories.doc(path).delete();
      emit(DeleteCategorySuccess(message: 'deleting category successfully'));
    } catch (e) {
      emit(DeleteCategoryFailure(errorMessage: e.toString()));
    }
  }
}
