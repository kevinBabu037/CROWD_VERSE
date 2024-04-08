import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/profile/profile_modle.dart';
import 'package:crowd_verse/data/repositories/profile/profile_serveces.dart';

part 'profile_details_event.dart';
part 'profile_details_state.dart';

class ProfileDetailsBloc extends Bloc<ProfileDetailsEvent, ProfileDetailsState> {
  ProfileDetailsBloc() : super(ProfileDetailsInitial()) {
    on<ProfileDetailsEvent>(disPlayProfile); 
  }

  Future<void> disPlayProfile(ProfileDetailsEvent event, Emitter<ProfileDetailsState> emit) async {
   
      ProfileModel? profile =await ProfileServices().getUserDetails();

        
      if (profile!=null) { 
        
        emit(ProfileSucessesState(profile: profile));
      }else if(profile==null){ 
        emit(ProfileLoadingState());
      }
      
  }

}
