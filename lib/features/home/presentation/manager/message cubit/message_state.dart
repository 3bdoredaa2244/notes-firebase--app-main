part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageSuccess extends MessageState {}

final class MessageFailure extends MessageState {
  final String errorMessage;

  MessageFailure({required this.errorMessage});
}
