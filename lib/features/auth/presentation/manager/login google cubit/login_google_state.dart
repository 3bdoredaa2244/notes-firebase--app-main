part of 'login_google_cubit.dart';

@immutable
sealed class LoginGoogleState {}

final class LoginGoogleInitial extends LoginGoogleState {}

final class LoginGoogleLoading extends LoginGoogleState {}

final class LoginGoogleSuccess extends LoginGoogleState {}

final class LoginGoogleFailure extends LoginGoogleState {
  final String errorMessage;

  LoginGoogleFailure({required this.errorMessage});
}
