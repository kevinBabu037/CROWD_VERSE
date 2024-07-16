import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:crowd_verse/application/presentation/authentication/login/screen_login.dart';
import 'package:crowd_verse/application/presentation/messages/messages.dart';
import 'package:crowd_verse/application/presentation/profile/profile_bloc/profile_details_bloc.dart';
import 'package:crowd_verse/application/presentation/settings/widgets/about_app.dart';
import 'package:crowd_verse/application/presentation/settings/widgets/block_list.dart';
import 'package:crowd_verse/application/presentation/settings/widgets/privacy_policy.dart';
import 'package:crowd_verse/application/presentation/settings/widgets/settings_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

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
        height: screenHeight*0.7, 
        decoration:const BoxDecoration(
          color: kClrLiteBlue,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
        ),
         child: Column(
          children: [
            kHeight20,
            SettingsItemWidget(
                icon:Icons.message_outlined , 
                title: 'Messages',
                onTap: () => kNavigationPush(context,const ScreenMessages()),
                ),

                SettingsItemWidget(
                icon:Icons.share , 
                title: 'Share', 
                onTap: ()async { 
                  await Share.share('App Link: https://www.amazon.com/dp/B0D4ZHLY55/ref=apps_sf_sta');
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