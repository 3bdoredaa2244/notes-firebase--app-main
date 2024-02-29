part of 'add_category_cubit.dart';

@immutable
sealed class AddCategoryState {}

final class AddCategoryInitial extends AddCategoryState {}

final class AddCategoryLoading extends AddCategoryState {}

final class AddCategorySuccess extends AddCategoryState {
  final String successMessage;

  AddCategorySuccess({required this.successMessage});
}

final class AddCategoryFailure extends AddCategoryState {
  final String error;

  AddCategoryFailure({required this.error});
}
