part of 'profile_details_bloc.dart';

 class ProfileDetailsState {
  
 }

final class ProfileDetailsInitial extends ProfileDetailsState {}

 class ProfileLoadingState extends ProfileDetailsState {}

final class ProfileSuccessState extends ProfileDetailsState{
  final ProfileModel profile;

  ProfileSuccessState({required this.profile});
}
 
class ProfileErrorState extends ProfileDetailsState {
  final String errorMessage;

   ProfileErrorState(this.errorMessage);
}
/////////////////

class DeleteStatusSuccesState extends ProfileDetailsState {}

////////////////


class EditProfileLoadingState extends  ProfileDetailsState{}

class EditProfileSuccessState extends  ProfileDetailsState{

}

class EditProfileErrorState extends  ProfileDetailsState{
 final String error;

  EditProfileErrorState({required this.error});

}

///////////////


class EditProfilePicLoadingState extends  ProfileDetailsState{}

class EditProfilePicSuccessState extends  ProfileDetailsState{}

class EditProfilePicErrorState extends  ProfileDetailsState{
 final String error;

  EditProfilePicErrorState({required this.error});

}

///////////////


class AddAboutTextSuccessState extends  ProfileDetailsState{}

///////////////



class AddStatusSuccessState extends  ProfileDetailsState{
 
}






