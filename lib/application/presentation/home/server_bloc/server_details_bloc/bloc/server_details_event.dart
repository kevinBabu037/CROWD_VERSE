part of 'server_details_bloc.dart';

@immutable
sealed class ServerDetailsEvent {}

class ServerDetailsFechEvent extends ServerDetailsEvent {
  final String serverId;

  ServerDetailsFechEvent({required this.serverId});
}