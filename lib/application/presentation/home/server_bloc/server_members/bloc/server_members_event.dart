part of 'server_members_bloc.dart';

@immutable
sealed class ServerMembersEvent {}


class GetAllServerMembers extends ServerMembersEvent {
  final String serverId;

  GetAllServerMembers({required this.serverId});
}


class LeaveServerEvent extends ServerMembersEvent {
  final String  serverId;

  LeaveServerEvent({required this.serverId});
}


class DeleteServerEvent extends ServerMembersEvent {
  final String  serverId;

  DeleteServerEvent({required this.serverId});
}