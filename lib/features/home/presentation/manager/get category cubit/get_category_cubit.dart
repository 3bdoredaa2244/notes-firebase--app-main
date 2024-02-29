import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_training/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  GetCategoryCubit() : super(GetCategoryInitial());
  late List<QueryDocumentSnapshot> categories;
  getCategory() async {
    emit(GetCategoryLoading());
    categories = [];
    try {
      QuerySnapshot response = await FirebaseFirestore.instance
          .collection(firstCollection)
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      categories.addAll(response.docs);
      emit(GetCategorySuccess());
    } catch (e) {
      emit(GetCategoryFailure(error: e.toString()));
    }
  }
}
