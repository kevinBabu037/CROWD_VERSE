part of 'server_bloc.dart';

@immutable
sealed class ServerEvent {}


class GetAllServerEvent extends ServerEvent {}


class CreateServerEvent extends ServerEvent {
  final String serverName;

  CreateServerEvent({required this.serverName});
}

class SelectServerImgEvent extends ServerEvent {}

class JoinServerEvent extends ServerEvent {
  final String serverId;

  JoinServerEvent({required this.serverId});
}