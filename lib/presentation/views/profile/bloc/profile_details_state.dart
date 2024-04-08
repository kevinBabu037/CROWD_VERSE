part of 'profile_details_bloc.dart';

 class ProfileDetailsState {
  
 }

final class ProfileDetailsInitial extends ProfileDetailsState {}

 class ProfileLoadingState extends ProfileDetailsState {}

final class ProfileSucessesState extends ProfileDetailsState{
  final ProfileModel profile;

  ProfileSucessesState({required this.profile});
}

class ProfileErrorState extends ProfileDetailsState {
  final String errorMessage;

   ProfileErrorState(this.errorMessage);
}