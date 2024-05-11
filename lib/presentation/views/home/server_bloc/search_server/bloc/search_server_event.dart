part of 'search_server_bloc.dart';

@immutable
sealed class SearchServerEvent {}


class SearchAllServerEvent extends SearchServerEvent {
  final String searchTxt;

  SearchAllServerEvent({required this.searchTxt});
}

