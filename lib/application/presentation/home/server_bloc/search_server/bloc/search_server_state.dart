part of 'search_server_bloc.dart';

@immutable
sealed class SearchServerState {}

final class SearchServerInitial extends SearchServerState {}

final class SearchServerLoadingState extends SearchServerState {}

final class SearchServerSuccessState extends SearchServerState {
 final List<SearchAllServerModel> server;


  SearchServerSuccessState({required this.server});}

final class SearchServerEmptyState extends SearchServerState {}




