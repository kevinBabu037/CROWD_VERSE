import 'package:crowd_verse/Application/controller/cubit/nav_bar.dart';
import 'package:crowd_verse/Application/core/color.dart';
import 'package:crowd_verse/Application/screens/messages/messages.dart';
import 'package:crowd_verse/Application/screens/notification/notification.dart';
import 'package:crowd_verse/Application/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../home/screen_home.dart';


class ScreenNavBar extends StatelessWidget {
  const ScreenNavBar({super. key});

  final List<Widget> _screens = const[
   ScreenHome(),
   ScreenMessages(),
   ScreenNotification(),
   ScreenProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavIndex, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          body: _screens[selectedIndex],
          bottomNavigationBar: Padding( 
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: GNav(
              onTabChange: (value) {
                context.read<NavIndex>().updateIndex(value);
              }, 
              activeColor:kClrBlue,   
               iconSize: 30,
              padding:const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              duration:const Duration(milliseconds: 500), 
               tabBackgroundColor:kClrLiteBlue,
              tabs:const [
                GButton( 
                  icon: Icons.home_outlined, 
                ),
                GButton( 
                  icon: Icons.message_outlined,  
                ),
                GButton(
                  icon: Icons.notifications_outlined,
                ),
                GButton(   
                  icon: Icons.person_outlined,
                ), 
              ],
            ),
          ),
        );
      },
    );
  }
}
