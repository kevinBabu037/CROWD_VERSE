part of 'login_bloc.dart';

class LoginEvent {}


class LoginAction extends LoginEvent{
 final String password;
  final String email;

  LoginAction({required this.password,required this.email});
}



class ForgotPassMailVerificationEvent extends LoginEvent{
 final String email;

  ForgotPassMailVerificationEvent({required this.email});
}


class ResetPassEvent extends LoginEvent{
  final String otp;
  final String newPassword;

  ResetPassEvent({required this.otp, required this.newPassword});
}