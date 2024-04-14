import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/repositories/Auth/auth_service.dart';
import 'package:http/http.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    
    on<LoginAction>(loginAction);
    on<ForgotPassMailVerificationEvent>(forgotPassMailVerificationEvent);
    on<ResetPassEvent>(resetPassEvent);

  }

  FutureOr<void> loginAction(LoginAction event, Emitter<LoginState> emit)async {

      
      bool isLogin=await AuthService().userLogin(event.email, event.password);
     
     if (isLogin) {
       emit(LoginSuccessState());
     }else{
       emit(LoginErrorState());
     }

  }

  FutureOr<void> forgotPassMailVerificationEvent(ForgotPassMailVerificationEvent event, Emitter<LoginState> emit)async {
      
      emit(ForgotPassMailLoadingState());
      Response? response=await AuthService().resetPasswordConfirmMail(event.email);

      final jsonresponse=jsonDecode(response!.body);

      
      
      if (response.statusCode==201) {
        emit(ForgotPassMailsuccessState());
      }else{
        String error=jsonresponse['error'];
        emit(ForgotPassMailErrorState(error: error));
      }

  }

  FutureOr<void> resetPassEvent(ResetPassEvent event, Emitter<LoginState> emit) async{

     bool res = await AuthService().resetPassword(event.newPassword, event.otp);

     if (res) {
       emit(ResetPasswordSuccessState());
     }else{
       emit(ResetPasswordErrorState(error:"Otp not match or expired"));
     }

  }
}
