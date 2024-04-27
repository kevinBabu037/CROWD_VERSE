part of 'friendly_message_bloc.dart';

@immutable
sealed class FriendlyMessageEvent {}

class GetAllMessagesEvent extends FriendlyMessageEvent {
  final String userId;

  GetAllMessagesEvent({required this.userId});
}
