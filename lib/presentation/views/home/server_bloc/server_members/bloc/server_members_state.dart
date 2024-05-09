part of 'server_members_bloc.dart';

@immutable
sealed class ServerMembersState {}

final class ServerMembersInitial extends ServerMembersState {}

final class ServerMembersLoadingState extends ServerMembersState {}

final class ServerMembersSuccessState extends ServerMembersState {
  final List<ServerMembersModel> members;

  ServerMembersSuccessState({required this.members});
}

final class ServerMembersEmptyState extends ServerMembersState {}

/////////////////


final class LeaveServerSuccessState extends ServerMembersState {}

final class LeaveServerErrorssState extends ServerMembersState {}

final class DeleteServerSuccessState extends ServerMembersState {}

final class DeleteServerErrorssState extends ServerMembersState {}