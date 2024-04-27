part of 'friendly_message_bloc.dart';

@immutable
sealed class FriendlyMessageState {}

final class FriendlyMessageInitial extends FriendlyMessageState {}

final class FriendlyMessageLoaddingState extends FriendlyMessageState {}

final class FriendlyMessageSuccessState extends FriendlyMessageState {
  final List<FriendlyChatModel>? model;

  FriendlyMessageSuccessState({required this.model});
}

final class FriendlyMessagEmptyState extends FriendlyMessageState {}


