import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_training/features/filter/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());
  List<UserModel> usersData = [];
  Future<List<UserModel>> test() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    try {
      emit(TestLoading());
      var response = await collection
          .orderBy('age', descending: false)
          .limit(3)
          .startAfter([22]).get();
      List<UserModel> usersData = response.docs
          .map((element) => UserModel.fromSnapShot(
                  element as DocumentSnapshot<Map<String, dynamic>>)
              /*UserModel(
                documentId: element.id,
                name: element['name'],
                age: element['age'],
                money: element['money'],
              )*/
              )
          .toList();
      emit(TestSuccess());
      return usersData;
    } catch (e) {
      emit(TestFailure(errorMessage: e.toString()));
      return [];
    }
  }
  /*test() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    try {
      emit(TestLoading());
      usersData = [];
      var response = await collection.get();
      for (var element in response.docs) {
        usersData.add(UserModel(
            documentId: element.id,
            name: element['name'],
            age: element['age'],
            money: element['money']));
      }
      /*usersData = response.docs
          .map((e) => UserModel.fromJson(e))
          .toList();*/

      /*for (var element in response.docs) {
        var user = UserModel.fromSnapShot(element);
        usersData.add(element);
      }*/
      emit(TestSuccess());
    } catch (e) {
      emit(TestFailure(errorMessage: e.toString()));
    }
  }*/
}
