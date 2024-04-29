part of 'friendly_message_bloc.dart';

@immutable
sealed class FriendlyMessageEvent {}

class GetAllMessagesEvent extends FriendlyMessageEvent {
  final String userId;

  GetAllMessagesEvent({required this.userId});
}


class ResiveMsgEvent extends FriendlyMessageEvent{
  final FriendlyChatModel chat;

  ResiveMsgEvent({required this.chat});
}




class SendMessageEvent extends FriendlyMessageEvent{
  final FriendlyChatModel chat;

  SendMessageEvent({required this.chat});
}
