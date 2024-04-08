import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/auth/user.dart';
import 'package:crowd_verse/data/repositories/Auth/auth_service.dart';
import 'package:http/http.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    
     on<SignupEvent>(signupEvent);

  }



  FutureOr<void> signupEvent(SignupEvent event, Emitter<SignupState> emit)async {
    
      emit(SignUpLoadingState());
      
      Response? response =await AuthService().createUser(event.user);
       final jsonResponse=jsonDecode(response!.body);
      if(response.statusCode==201){
        
       
        String confirmToken = jsonResponse['result']['TemperveryToken'];
      
         emit(SignUpSuccessState(confirmToken: confirmToken));
      }else{
        String error=jsonResponse['error'];
         emit(SignUpErroeState(error:error));
      }

  }




}
