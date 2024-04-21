part of 'friends_bloc.dart';

 class FriendsEvent {}

 
 class GetAllFriendsEvent extends FriendsEvent{}

 class GetAllFriendRequestsEvent extends FriendsEvent{}

class AccepttRequestEvent extends  FriendsEvent{
 final String friendshipId;
 final String acceptOrReject;

  AccepttRequestEvent({required this.friendshipId, required this.acceptOrReject});

}


class RejectttRequestEvent extends  FriendsEvent{
 final String friendshipId;
 final String acceptOrReject;

  RejectttRequestEvent({required this.friendshipId, required this.acceptOrReject});

}


 class PendingRequestsEvent extends FriendsEvent{}



class RemoveFromPendingrequestsEvent extends FriendsEvent{
  final String friendshipId;

  RemoveFromPendingrequestsEvent({required this.friendshipId});
}

class SearchAllUsersEvent extends FriendsEvent{
  final String searchTxt;

  SearchAllUsersEvent({required this.searchTxt});
}

class PublicUserProfileDisplayEvent extends  FriendsEvent{
 final String id;

  PublicUserProfileDisplayEvent({required this.id});
}
class CreateFriendEvent extends  FriendsEvent{
 final String id;

  CreateFriendEvent({required this.id});
}

class BlockUserEvent extends FriendsEvent{
  final String friendShipId;

  BlockUserEvent({required this.friendShipId});
}

class GetAllBlockListEvent extends FriendsEvent{}


class UnBlockUser extends FriendsEvent{
  final String friendShipId;
  UnBlockUser({required this.friendShipId});
}