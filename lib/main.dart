import 'package:crowd_verse/data/repositories/flriedly_chat/friendly_chat.dart';
import 'package:crowd_verse/presentation/views/authentication/login/bloc/bloc/login_bloc.dart';
import 'package:crowd_verse/presentation/views/authentication/signup/bloc/bloc/signup_bloc.dart';
import 'package:crowd_verse/presentation/views/messages/message_bloc/bloc/friendly_message_bloc.dart';
import 'package:crowd_verse/presentation/views/nav_bar/cubit/nav_bar.dart';
import 'package:crowd_verse/presentation/views/nav_bar/nav_bar.dart';
import 'package:crowd_verse/presentation/views/friends/friends_bloc/friends_bloc.dart';
import 'package:crowd_verse/presentation/views/splash/screen_splash.dart';
import 'package:crowd_verse/data/sharedprefrense/shared_prefrense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/views/profile/profile_bloc/profile_details_bloc.dart';

 


void main()async {
   WidgetsFlutterBinding.ensureInitialized();
    bool isLoggedIn = await SharedPreferenses.getBoolValue() ?? false;
    FriendlyChatService().connectSocket();
  runApp( MyApp(isLogin:isLoggedIn));
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key,required this.isLogin});
  
  final bool isLogin;

  @override 
  Widget build(BuildContext context) {
     
    return 
     MultiBlocProvider(    
      providers: [
       BlocProvider(create: (context) => NavIndex(),), 
       BlocProvider(create: (context) => ProfileDetailsBloc(),), 
       BlocProvider(create: (context) => SignupBloc(),), 
       BlocProvider(create: (context) => LoginBloc(),),
       BlocProvider(create: (context) => FriendsBloc(),), 
       BlocProvider(create: (context) => FriendlyMessageBloc(),),
      ],
      child: 
      MaterialApp(
        debugShowCheckedModeBanner: false, 
        theme: ThemeData( 
          textTheme: GoogleFonts.workSansTextTheme().copyWith(     
            displayLarge: GoogleFonts.workSans(),),
          fontFamily: GoogleFonts.roboto().fontFamily,
        ), 
        home:isLogin?const ScreenNavBar() :const ScreenSplash() 
      ));
      
     
  }
}
