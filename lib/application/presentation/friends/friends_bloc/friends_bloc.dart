import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/friends/block_list_model.dart';
import 'package:crowd_verse/data/models/friends/friend_requests.dart';
import 'package:crowd_verse/data/models/friends/friends_model.dart';
import 'package:crowd_verse/data/models/friends/search_all_user.dart';
import 'package:crowd_verse/data/models/profile/public_profile_model.dart';
import 'package:crowd_verse/data/repositories/friends/friends_serveces.dart';
import 'package:crowd_verse/data/repositories/profile/profile_serveces.dart';
part 'friends_event.dart';
part 'friends_state.dart';
 
class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc() : super(FriendsInitial()) {
    on<GetAllFriendsEvent>(friendsEvent); 
    on<GetAllFriendRequestsEvent>(getAllFriendRequestsEvent);
    on<AccepttRequestEvent>(accepttRequestEvent); 
    on<RejectttRequestEvent>(rejectttRequestEvent);
    on<PendingRequestsEvent>(pendingRequests);
    on<RemoveFromPendingrequestsEvent>(removeFromPendingrequestsEvent);
    on<SearchAllUsersEvent>(searchAllUsersEvent);
    on<PublicUserProfileDisplayEvent>(publicUserProfileDisplayEvent);
    on<BlockUserEvent>(blockUserEvent);
    on<UnBlockUser>(unBlockUser);
    on<GetAllBlockListEvent>(getAllBlockList);
  }
 
  
  FutureOr<void> friendsEvent(GetAllFriendsEvent event, Emitter<FriendsState> emit)async{ 
      
    emit(GetAllFriendsLoadingState()); 
 
   List<FriendsModel>? friends = await FriendsServeses().getAllFriends(); 
  
   if (friends!=null) {  
      emit(GetAllFriendsSuccsessState(friends: friends));  
   }else{  
        emit(GetAllFriendsEmptyState()); 
   }  
  
  }
   


  FutureOr<void> getAllFriendRequestsEvent(GetAllFriendRequestsEvent event, Emitter<FriendsState> emit)async{
     
    emit(GetAllFriendRequestsLoadingState());  

    List<FriendRequestsModel>? friendsReq = await FriendsServeses().getAllRequests();

    if (friendsReq!=null) {   
      emit(GetAllFriendRequestsSuccesstate(friends: friendsReq));   
   }else{  
        emit(GetAllFriendRequestsEmptyState());  
   } 
  
  }

  FutureOr<void> accepttRequestEvent(AccepttRequestEvent event, Emitter<FriendsState> emit)async{

   bool res = await FriendsServeses().requstAcceptOrReject(event.acceptOrReject, event.friendshipId);
    List<FriendRequestsModel>? friendsReq = await FriendsServeses().getAllRequests();

   if (res) {
      emit(AcceptRequestSuccessState());     
   } 
   if (friendsReq!=null) {
     emit(GetAllFriendRequestsSuccesstate(friends: friendsReq)); 
   }


  }

  FutureOr<void> rejectttRequestEvent(RejectttRequestEvent event, Emitter<FriendsState> emit)async{
     bool res = await FriendsServeses().requstAcceptOrReject(event.acceptOrReject, event.friendshipId);
     List<FriendRequestsModel>? friendsReq = await FriendsServeses().getAllRequests();
   if (res) {
       
      emit(RejectRequestSuccessState());   
   }
   if (friendsReq!=null) {
     emit(GetAllFriendRequestsSuccesstate(friends: friendsReq)); 
   }
  }

  FutureOr<void> pendingRequests(PendingRequestsEvent event, Emitter<FriendsState> emit)async{

    
   emit(PendingFriendsLoadingState());  

    List<FriendRequestsModel>? friendsReq = await FriendsServeses().requstSendedList();

    if (friendsReq!=null) {   
      emit(PendingFriendsSuccessState(friends: friendsReq));   
   }else{  
        emit(PendingFriendsEmptyState());  
   } 

  }

  FutureOr<void> removeFromPendingrequestsEvent(RemoveFromPendingrequestsEvent event, Emitter<FriendsState> emit)async{
      bool res = await FriendsServeses().removeFromPending(event.friendshipId);
      List<FriendRequestsModel>? friendsReq = await FriendsServeses().requstSendedList();
   if (res) {
        
      emit(RemoveFromPendingReuestSuccessState());   
   }
   if (friendsReq!=null) {
     emit(PendingFriendsSuccessState(friends: friendsReq));  
   }
  }

  FutureOr<void> searchAllUsersEvent(SearchAllUsersEvent event, Emitter<FriendsState> emit)async{


    emit(SearchAllUserLoadingState());
    
    await Future.delayed(const Duration(milliseconds:700)); 
    List<SearchAllUserModel>? users = await FriendsServeses().searchAllFriends(event.searchTxt);

    if (users!=null) {
      emit(SearchAllUserSuccessState(users:users));
    } 
    if(users == null|| users.isEmpty){
      emit(SearchAllUserEmptyState());
    }


  }

  FutureOr<void> publicUserProfileDisplayEvent(PublicUserProfileDisplayEvent event, Emitter<FriendsState> emit)async{

     emit(PublicProfileLoadingState());

    PublicProfileModel? model = await ProfileServices().publicUserAllDetails(event.id);

       if (model!=null) {
        emit(PublicProfileSuccessState(users: model));
       }
       
  }


  
  FutureOr<void> blockUserEvent(BlockUserEvent event, Emitter<FriendsState> emit)async {

       bool res = await FriendsServeses().blockOrUnBlock(event.friendShipId,'block'); 
        List<FriendsModel>? friends = await FriendsServeses().getAllFriends(); 
 
       if (res) {
         emit(BlockUserSuccessState());
         emit(GetAllFriendsSuccsessState(friends: friends!));
       }
  }

  FutureOr<void> getAllBlockList(GetAllBlockListEvent event, Emitter<FriendsState> emit)async{

     emit(GetAllBlockListLoadingState());

     List<BlockListModel>? blockLst = await FriendsServeses().getAllBlockList();
    
    if (blockLst!=null) {
      emit(GetAllBlockListSuccsessState(blockLst: blockLst));
    }
    if (blockLst==null) {
      emit(GetAllBlockListEmptyState()); 
    }
     
  }

  FutureOr<void> unBlockUser(UnBlockUser event, Emitter<FriendsState> emit)async{
      bool res = await FriendsServeses().blockOrUnBlock(event.friendShipId,'unblock'); 
          List<BlockListModel>? blockLst = await FriendsServeses().getAllBlockList();

     if (res) {
        emit(UnBlockSuccessState());
        emit(GetAllBlockListSuccsessState(blockLst: blockLst!));
     }
   
  }
}

