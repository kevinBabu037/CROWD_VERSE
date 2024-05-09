part of 'server_bloc.dart';

@immutable
sealed class ServerState {}

final class ServerInitial extends ServerState {}

final class ServerLoadingState extends ServerState {}

final class ServerSuccessState extends ServerState {
 final List<ServerModel>? servers;

  ServerSuccessState({required this.servers});
}

final class ServerEmptyState extends ServerState {}


/////////////////////


final class CreateServerSuccessState extends ServerState {}



final class CreateServerErrorState extends ServerState {}


final class JoinServerSuccessState extends ServerState {}

final class JoinServerErroeState extends ServerState {}




