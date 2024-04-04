import 'package:crowd_verse/Application/controller/cubit/nav_bar.dart';
import 'package:crowd_verse/Application/screens/nav_bar/nav_bar.dart';
import 'package:crowd_verse/Application/screens/splash/screen_splash.dart';
import 'package:crowd_verse/Data/Sharedprefrense/shared_prefrense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';



void main()async {
   WidgetsFlutterBinding.ensureInitialized();
     bool isLoggedIn = await SharedPreferenses.getBoolValue() ?? false;

  runApp( MyApp(isLogin:isLoggedIn ,));
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
