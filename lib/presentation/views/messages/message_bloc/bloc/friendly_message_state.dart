part of 'friendly_message_bloc.dart';

@immutable
sealed class FriendlyMessageState {
 final List<FriendlyChatModel>? model;

  FriendlyMessageState({required this.model});
}

final class FriendlyMessageInitial extends FriendlyMessageState {
  FriendlyMessageInitial({required super.model});
  
}

final class FriendlyMessageLoaddingState extends FriendlyMessageState {
  FriendlyMessageLoaddingState({ super.model});
}

final class FriendlyMessageSuccessState extends FriendlyMessageState {
  final List<FriendlyChatModel>? model;

  FriendlyMessageSuccessState({required this.model}) : super(model: []);
}

final class FriendlyMessagEmptyState extends FriendlyMessageState {
  FriendlyMessagEmptyState({ super.model});
}


////////////////////////


