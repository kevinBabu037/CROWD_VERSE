part of 'friends_bloc.dart';

sealed class FriendsState {}

final class FriendsInitial extends FriendsState {}

final class GetAllFriendsLoadingState extends FriendsState {}

final class GetAllFriendsSuccsessState extends FriendsState {
  final List<FriendsModel> friends;

  GetAllFriendsSuccsessState({required this.friends});
}

final class GetAllFriendsEmptyState extends FriendsState {}

final class GetAllFriendsErrorState extends FriendsState {}

/////////////


final class GetAllFriendRequestsLoadingState extends FriendsState {}


final class GetAllFriendRequestsSuccesstate extends FriendsState {
  final List<FriendRequestsModel> friends;

  GetAllFriendRequestsSuccesstate({required this.friends});
}

final class GetAllFriendRequestsEmptyState extends FriendsState {}

final class GetAllFriendRequestsErrorState extends FriendsState {}


///////////////


final class AcceptRequestSuccessState extends FriendsState {}

final class RejectRequestSuccessState extends FriendsState {}

///////////////////


final class PendingFriendsLoadingState extends FriendsState {}


final class PendingFriendsSuccessState extends FriendsState {
  final List<FriendRequestsModel> friends;

  PendingFriendsSuccessState({required this.friends});
}

final class PendingFriendsEmptyState extends FriendsState {}

final class RemoveFromPendingReuestSuccessState extends FriendsState {}


/////////////////////


final class SearchAllUserLoadingState extends FriendsState {}


final class SearchAllUserSuccessState extends FriendsState {
 final List<SearchAllUserModel> users;

  SearchAllUserSuccessState({required this.users});
}

final class SearchAllUserEmptyState extends FriendsState {}

// final class GetAllFriendRequestsErrorState extends FriendsState {}


//////////////////



final class PublicProfileLoadingState extends FriendsState {}


final class PublicProfileSuccessState extends FriendsState {
 PublicProfileModel users;

  PublicProfileSuccessState({required this.users});
}

final class PublicProfileErrorState extends FriendsState {}


/////////////////




final class CreateFriendLoadingState extends  FriendsState {}

final class CreateFriendRequestSentState extends  FriendsState {}

final class CreateFriendRequestSentSuccessState extends  FriendsState {}

final class CreateFriendErrorState extends  FriendsState {
  final String errorMsg;

  CreateFriendErrorState({required this.errorMsg});
}


/////////////////



final class BlockUserSuccessState extends FriendsState {}

final class BlockUserErrorState extends FriendsState {}

/////////////////////


 class GetAllBlockListLoadingState extends FriendsState {}

final class GetAllBlockListSuccsessState extends FriendsState {
  final List<BlockListModel> blockLst; 

  GetAllBlockListSuccsessState({required this.blockLst});
}

final class GetAllBlockListEmptyState extends FriendsState {}

///////////////  


final class UnBlockSuccessState extends FriendsState {}
