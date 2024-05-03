part of 'server_bloc.dart';

@immutable
sealed class ServerEvent {}


class GetAllServerEvent extends ServerEvent {}
