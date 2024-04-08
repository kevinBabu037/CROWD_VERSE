part of 'signup_bloc.dart';

 class SignupState {}

final class SignupInitial extends SignupState {}

final class SignUpLoadingState extends SignupState{}

final class SignUpSuccessState extends SignupState{
  final String confirmToken;

  SignUpSuccessState({required this.confirmToken});
}



final class SignUpErroeState extends SignupState{
  final String error;

  SignUpErroeState({required this.error});
}
