import 'package:crowd_verse/presentation/views/authentication/login/bloc/bloc/login_bloc.dart';
import 'package:crowd_verse/presentation/views/authentication/signup/bloc/bloc/signup_bloc.dart';
import 'package:crowd_verse/presentation/views/home/cubit/selected_server_border.dart';
import 'package:crowd_verse/presentation/views/home/cubit/server_expanded.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/category_bloc/bloc/category_bloc.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/channel_bloc/bloc/channel_bloc.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/channel_chat/bloc/channel_chat_bloc.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/edit_server/bloc/edit_server_bloc.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/search_server/bloc/search_server_bloc.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/server_details_bloc/bloc/server_details_bloc.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/server_list_bloc/server_bloc.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/server_members/bloc/server_members_bloc.dart';
import 'package:crowd_verse/presentation/views/messages/cubit/max_line_textform.dart';
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
  runApp( MyApp(isLogin:isLoggedIn));
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key,required this.isLogin});
  
  final bool isLogin;

  @override 
  Widget build(BuildContext context){

    return 
     MultiBlocProvider(    
      providers: [  
       BlocProvider(create: (context) => ChannelChatBloc(),),
       BlocProvider(create: (context) => CategoryBloc(),),
       BlocProvider(create: (context) => ExpansionCubit(),), 
       BlocProvider(create: (context) => ChannelBloc(),),
       BlocProvider(create: (context) => SearchServerBloc(),),
       BlocProvider(create: (context) => EditServerBloc(),),
       BlocProvider(create: (context) => ServerMembersBloc(),), 
       BlocProvider(create: (context) => ServerDetailsBloc(),), 
       BlocProvider(create: (context) => ServerBloc(),), 
       BlocProvider(create: (context) => ServerListCubit(),),   
       BlocProvider(create: (context) => NavIndex(),),  
       BlocProvider(create: (context) => MaxLineCubit(),),
       BlocProvider(create: (context) => ProfileDetailsBloc(),), 
       BlocProvider(create: (context) => SignupBloc(),), 
       BlocProvider(create: (context) => LoginBloc(),),
       BlocProvider(create: (context) => FriendsBloc(),), 
       BlocProvider(create: (context) => FriendlyMessageBloc(),),
      ],
      child:   
      MaterialApp( 
        debugShowCheckedModeBanner: false,  
        theme:
         ThemeData( 
           
          textTheme: GoogleFonts.workSansTextTheme().copyWith(     
            displayLarge: GoogleFonts.workSans(),),
          fontFamily: GoogleFonts.roboto().fontFamily,
        ), 
        home:isLogin?const ScreenNavBar() :const ScreenSplash() 
      ));
      
     
  }
}

