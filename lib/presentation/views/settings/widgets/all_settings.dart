import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/authentication/login/screen_login.dart';
import 'package:crowd_verse/presentation/views/messages/messages.dart';
import 'package:crowd_verse/presentation/views/profile/profile_bloc/profile_details_bloc.dart';
import 'package:crowd_verse/presentation/views/settings/widgets/about_app.dart';
import 'package:crowd_verse/presentation/views/settings/widgets/block_list.dart';
import 'package:crowd_verse/presentation/views/settings/widgets/privacy_policy.dart';
import 'package:crowd_verse/presentation/views/settings/widgets/settings_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsAllItemswidget extends StatelessWidget {
  const SettingsAllItemswidget({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: screenHeight*0.7+15, 
        decoration:const BoxDecoration(
          color: kClrLiteBlue,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
        ),
         child: Column(
          children: [
            kHeight15,
            SettingsItemWidget(
                icon:Icons.message_outlined , 
                title: 'Messages',
                onTap: () => kNavigationPush(context,const ScreenMessages()),
                ),

                SettingsItemWidget(
                icon:Icons.share , 
                title: 'Share', 
                onTap: () {
                  
                },
                ),

            SettingsItemWidget(
                icon:Icons.privacy_tip_outlined  , 
                title: 'Privacy Policy',
                onTap: () {
                  kNavigationPush(context,const PrivacyPolicy());
                },
                ),

            SettingsItemWidget(
                icon:Icons.info_outline , 
                title: 'About', 
                onTap: () {
                  kNavigationPush(context,const AboutAppWidget());
                },
                ),
                

            SettingsItemWidget(
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
            child: SettingsItemWidget(
              icon: Icons.logout,
              title: "Log Out",),
          ),
          
          ],
        ),
      ),
    );
  }
}