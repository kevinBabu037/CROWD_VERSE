part of 'signup_bloc.dart';

class SignupEvent {
   UserModel? user;

  SignupEvent({required this.user});


}

class MailverifyEvent extends SignupEvent{
  MailverifyEvent({
    super.user,
    required this.token
  });
 final String token;
  
}


