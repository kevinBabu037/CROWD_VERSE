part of 'channel_bloc.dart';

@immutable
sealed class ChannelState {}

final class ChannelInitial extends ChannelState {}


final class ChannelLoadingState extends ChannelState {}

final class ChannelSuccessState extends ChannelState {
  final List<ChannelModel> channels;

  ChannelSuccessState({required this.channels});
}

final class ChannelErroegState extends ChannelState {}



