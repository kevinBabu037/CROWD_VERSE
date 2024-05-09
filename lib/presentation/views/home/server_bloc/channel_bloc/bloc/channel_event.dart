part of 'channel_bloc.dart';

@immutable
sealed class ChannelEvent {}

class FechAllChannelsEvent extends ChannelEvent {
  final String serverID;

  FechAllChannelsEvent({required this.serverID});
}
