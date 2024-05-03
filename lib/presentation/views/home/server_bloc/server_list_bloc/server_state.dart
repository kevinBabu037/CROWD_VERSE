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



