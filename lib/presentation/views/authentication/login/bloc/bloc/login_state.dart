part of 'login_bloc.dart';

 class LoginState {}

final class LoginInitial extends LoginState {}


final class LoginSuccessState extends LoginState {}

final class LoginErrorState extends LoginState {}

////////////////


class ForgotPassMailLoadingState extends  LoginState  {}

class ForgotPassMailsuccessState extends  LoginState  {}

class ForgotPassMailErrorState extends  LoginState  {
 final String error;

  ForgotPassMailErrorState({required this.error});
}

////////////////


class  ResetPasswordSuccessState  extends LoginState{}


class  ResetPasswordErrorState  extends LoginState{
   final String error;

  ResetPasswordErrorState({required this.error});
}