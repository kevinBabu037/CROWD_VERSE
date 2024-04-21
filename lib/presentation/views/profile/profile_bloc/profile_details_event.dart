part of 'profile_details_bloc.dart';

class ProfileDetailsEvent {}

class DisplayProfileEvent extends ProfileDetailsEvent{}

class DeleteStatusEvent extends ProfileDetailsEvent{} 

/////////////// 

class EditProfileEvent extends ProfileDetailsEvent{}


class EditProfilePicEvent extends  ProfileDetailsEvent{}

class AddAboutTextEvent extends  ProfileDetailsEvent{
  final String txt;

  AddAboutTextEvent({required this.txt});
}

//////////////////


  class  AddStatusEvent extends  ProfileDetailsEvent{
    final String txt;

  AddStatusEvent({ required this.txt});
  }

  /////////////////////
  


   class  DeleteProfilePicAndCoverPicEvent extends ProfileDetailsEvent{
   final String type;

  DeleteProfilePicAndCoverPicEvent({required this.type});
   }



////////////////

class LogoutEvent extends ProfileDetailsEvent{}


