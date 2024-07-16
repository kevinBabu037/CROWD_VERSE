part of 'server_details_bloc.dart';

@immutable
sealed class ServerDetailsState {}

final class ServerDetailsInitial extends ServerDetailsState {}


final class ServerDetailsLoadingState extends ServerDetailsState {}

final class ServerDetailsSuccessState extends ServerDetailsState {
  final ServerDetailsModel server;

  ServerDetailsSuccessState({required this.server});
}



 