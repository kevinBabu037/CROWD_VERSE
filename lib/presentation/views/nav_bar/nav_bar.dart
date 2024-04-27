import 'package:crowd_verse/presentation/views/friends/friends_bloc/friends_bloc.dart';
import 'package:crowd_verse/presentation/views/nav_bar/cubit/nav_bar.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/views/messages/messages.dart';
import 'package:crowd_verse/presentation/views/notification/notification.dart';
import 'package:crowd_verse/presentation/views/profile/screen_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../home/screen_home.dart';


class ScreenNavBar extends StatefulWidget {
  const ScreenNavBar({super. key});

  @override
  State<ScreenNavBar> createState() => _ScreenNavBarState();
}

class _ScreenNavBarState extends State<ScreenNavBar> {
  final List<Widget> _screens = const[
   ScreenHome(),
   ScreenMessages(),
   ScreenNotification(),
   ScreenProfile()
  ];
 
  @override
  Widget build(BuildContext context) {
      context.read<FriendsBloc>().add(GetAllFriendRequestsEvent());    
    return BlocBuilder<NavIndex, int>(
      builder: (context, selectedIndex) {
        return Scaffold(  
          body: _screens[selectedIndex], 
          bottomNavigationBar: Padding(  
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Stack(
              children: [
                GNav(
                
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
                      icon: CupertinoIcons.home 
                    ),
                    GButton( 
                      icon: CupertinoIcons.chat_bubble_2,  
                    ),
                    GButton(
                      icon: CupertinoIcons.bell,
                    ),
                    GButton(   
                      icon: CupertinoIcons.person,
                    ), 
                  ],
                ),
              BlocBuilder<FriendsBloc, FriendsState>(
                builder: (context, state) {
                 if (state is GetAllFriendRequestsSuccesstate) {
                   return  Positioned(
                               bottom: 7,
                               right: 120,  
                               child:  CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 8,  
                                  child: Center(child: Text(state.friends.length.toString(),style:const TextStyle(color: kClrWhite,fontSize: 12),)),
                                ),
                             );
                 } 
                 return const SizedBox();
                },
              ) 
              ],
            ),
          ),
        );
      },
    );
  }
}
