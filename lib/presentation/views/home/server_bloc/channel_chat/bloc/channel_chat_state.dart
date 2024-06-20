part of 'channel_chat_bloc.dart';

@immutable
sealed class ChannelChatState {}

final class ChannelChatInitial extends ChannelChatState {}

final class ChannelChatLoadingState extends ChannelChatState {}

final class ChannelChatSuccussState extends ChannelChatState {
  final List <ChannelChatModel> chat;

  ChannelChatSuccussState({required this.chat});
}

final class ChannelChatEmptyState extends ChannelChatState {}



 