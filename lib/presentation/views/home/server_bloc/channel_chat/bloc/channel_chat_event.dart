part of 'channel_chat_bloc.dart';

@immutable
sealed class ChannelChatEvent {}

final class FechAllChannelMessages extends ChannelChatEvent {
  final String chanelID;

  FechAllChannelMessages({required this.chanelID});
}


final class ReciveChannelMessageEvent extends ChannelChatEvent {
  final ChannelChatModel chat;

  ReciveChannelMessageEvent({required this.chat});
}