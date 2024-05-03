import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/profile/profile_bloc/profile_details_bloc.dart';
import 'package:crowd_verse/presentation/views/settings/widgets/block_list.dart';
import 'package:crowd_verse/presentation/widgets/costum_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication/login/screen_login.dart';
import 'widgets/settings_items_widget.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kClrProfileScafold,
      appBar:
       CustomAppBar(
        icon: Icons.arrow_back, 
        title: 'Settings',
       onPressed: () {
         Navigator.pop(context); 
       },
      ),
      body: Column(
        children: [
          kHeight10,
          
          SettingsItemsWidget(
              icon: Icons.block, 
              title: "Block List",
              onTap: () {
                kNavigationPush(context,const BlockList());
              },
              ),
      
            GestureDetector(
            onTap: () {
              kShowDialog(
              context: context, 
              title: 'Log Out',
              contentTxt: "Are you sure want to logout ?", 
              actionBtn1Txt: "cancel", 
              actionBtn2Txt: "Log Out", 
              onPressed: () {
              context.read<ProfileDetailsBloc>().add(LogoutEvent()); 
              kNavigationPushRemoveUntil(context,const ScreenLogIn());
               },
              );            
            },
            child: SettingsItemsWidget(
              icon: Icons.logout,
              title: "Log Out",),
          ),
          
         
        ],
      ),
    );
  }
}

