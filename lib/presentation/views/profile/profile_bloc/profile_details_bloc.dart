import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/profile/profile_modle.dart';
import 'package:crowd_verse/data/repositories/profile/profile_serveces.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_details_event.dart';
part 'profile_details_state.dart';

class ProfileDetailsBloc extends Bloc<ProfileDetailsEvent, ProfileDetailsState> {
  ProfileDetailsBloc() : super(ProfileDetailsInitial()) {
    on<ProfileDetailsEvent>(disPlayProfile); 
    on<DeleteStatusEvent>(deleteStatusEvent);
    on<EditProfileEvent>(editProfileEvent);
    on<EditProfilePicEvent>(editProfilePicEvent);
    on<AddAboutTextEvent>(addAboutTextEvent);
    on<AddStatusEvent>(addStatusEvent);
  } 

  Future<void> disPlayProfile(ProfileDetailsEvent event, Emitter<ProfileDetailsState> emit) async {
   
       emit(ProfileLoadingState());

     ProfileModel? model =await ProfileServices().getUserDetails();
       if (model!=null) {
          emit(ProfileSuccessState(profile:model));
       }else{
           emit(ProfileErrorState('error')); 
       } 
      
     
   
  } 
  

  FutureOr<void> deleteStatusEvent(DeleteStatusEvent event, Emitter<ProfileDetailsState> emit)async {

      bool res= await ProfileServices().deleteStatus();
      ProfileModel? model =await ProfileServices().getUserDetails();

      if (model!=null&&res) {  
        emit(ProfileSuccessState(profile: model)); 
      }

  }

 

  FutureOr<void> editProfileEvent(EditProfileEvent event, Emitter<ProfileDetailsState> emit)async {

   
    emit(EditProfileLoadingState());  

    final imagePicking = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicking!=null) {
      int statusCode=await  ProfileServices().uploadCoverPic(imagePicking.path);
        
            ProfileModel? model =await ProfileServices().getUserDetails(); 
       if (statusCode==200&& model!=null) {
          
        emit(ProfileSuccessState(profile: model)); 
       }
       else {
        emit(EditProfileErrorState(error:'Image should be less than 1Mb'));
       }
       

     }

  
  }
 



  FutureOr<void> editProfilePicEvent(EditProfilePicEvent event, Emitter<ProfileDetailsState> emit)async {
    
    emit(EditProfilePicLoadingState());  

    final imagePicking = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicking!=null) {
      int statusCode=await  ProfileServices().uploadProfilePic(imagePicking.path);
        
            ProfileModel? model =await ProfileServices().getUserDetails(); 
       if (statusCode==200&& model!=null) { 
          
        emit(ProfileSuccessState(profile: model)); 
       }
       else { 
        emit(EditProfilePicErrorState(error:'Image should be less than 1Mb'));
       }
        

     }
 
  }

  FutureOr<void> addAboutTextEvent(AddAboutTextEvent event, Emitter<ProfileDetailsState> emit)async {


      await ProfileServices().addDiscription(event.txt);
           ProfileModel? model =await ProfileServices().getUserDetails(); 
       if ( model!=null) { 
          
        emit(ProfileSuccessState(profile: model)); 
       }
  } 







  FutureOr<void> addStatusEvent(AddStatusEvent event, Emitter<ProfileDetailsState> emit)async {

     bool res = await ProfileServices().addStatus(event.txt,);
        ProfileModel? model =await ProfileServices().getUserDetails(); 
       if (res) { 
        emit(AddStatusSuccessState());
        emit(ProfileSuccessState(profile: model!)); 
       }
  }
} 
