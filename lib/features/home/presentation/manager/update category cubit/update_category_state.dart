part of 'update_category_cubit.dart';

@immutable
sealed class UpdateCategoryState {}

final class UpdateCategoryInitial extends UpdateCategoryState {}

final class UpdateCategoryLoading extends UpdateCategoryState {}

final class UpdateCategorySuccess extends UpdateCategoryState {
  final String successMessage;

  UpdateCategorySuccess({required this.successMessage});
}

final class UpdateCategoryFailure extends UpdateCategoryState {
  final String errorMessage;

  UpdateCategoryFailure({required this.errorMessage});
}
