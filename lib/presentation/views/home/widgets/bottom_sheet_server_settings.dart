import 'package:crowd_verse/data/models/server/server_details.dart';

import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/server_members/bloc/server_members_bloc.dart';
import 'package:crowd_verse/presentation/views/home/widgets/all_categoryes.dart';
import 'package:crowd_verse/presentation/views/home/widgets/edit_server_details.dart';
import 'package:crowd_verse/presentation/views/home/widgets/server_members.dart';
import 'package:crowd_verse/presentation/views/nav_bar/nav_bar.dart';
import 'package:crowd_verse/presentation/views/settings/widgets/settings_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bottomSheetServerSettings({
   required BuildContext context,
    required ServerDetailsModel data,
    required String serverId,
   }) {
    showModalBottomSheet( 

      context: context,  
      builder: (BuildContext context) {  

        
        
        return SingleChildScrollView(
          child: Container(   
            decoration: BoxDecoration(   
            color: kClrLiteBlue,      
            borderRadius: BorderRadius.circular(20),     
            ),
               
            child: Column(   
              mainAxisAlignment: MainAxisAlignment.start,    
              children: [      
               Row(mainAxisAlignment: MainAxisAlignment.end, children: [IconButton(onPressed: (){Navigator.pop(context);}, icon:const Icon(Icons.close))],),
                data.discription!=null?
                Column(  
                children: [
                  const Text('Discription',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                   Padding(
                     padding:const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                     child: Text(data.discription!,style:const TextStyle(fontSize:16),),
                   ),
                ],  
              ):const SizedBox(),

              SettingsItemWidget( 
                icon: Icons.edit_outlined,   
                title: 'Edit Server',   
                onTap: () { 
                  editServerDetails(context: context,serverId: serverId); 
                  
                },
                ), 

               SettingsItemWidget( 
                icon: Icons.add,   
                title: 'Create Channel',     
                onTap: () { 
                  kNavigationPush(context, AllCategorySWidget(serverID: serverId,));
                  
                },
                ),
 
               SettingsItemWidget( 
                icon: Icons.people_alt_outlined, 
                title: 'Members', 
                onTap: () { 
                  
                  kNavigationPush(context, ServerMembers(serverId:serverId));
                },
                ), 
               BlocConsumer<ServerMembersBloc, ServerMembersState>( 
                 listener: (context, state) {
                  if (state is LeaveServerSuccessState) {
                    kSnakBar(context, "Leaved SuccessFuly", kClrLiteGreen);
                  }
                   if(state is LeaveServerErrorssState){
                    kSnakBar(context, "Admin can't Leave", kClrLiteRed);
                   }
                 },
                 builder: (context, state) {
                   return SettingsItemWidget(
                               icon: Icons.exit_to_app_outlined, 
                               title: 'leave Server',
                               onTap: ()async {
                                kShowDialog(
                                 context: context,
                                  title: "Leave", 
                                  contentTxt: "Are you sure want to leave?", 
                                  actionBtn1Txt: "Cancel", 
                                  actionBtn2Txt: 'Leave', 
                                  onPressed: ()async{
                                context.read<ServerMembersBloc>().add(LeaveServerEvent(serverId: serverId));
                                 kNavigationPushReplacement(context,const ScreenNavBar());
                                  }
                                  );
                               },
                               );
                 },
               ), 

                BlocConsumer<ServerMembersBloc, ServerMembersState>(
                  listener: (context, state) {
                   if(state is DeleteServerErrorssState){
                    kSnakBar(context, "Only admin can delete", kClrLiteRed);
                   }
                  },
                  builder: (context, state) {
                    return SettingsItemWidget(
                               icon: Icons.delete_outline, 
                               title: 'Delete Server', 
                               onTap: ()async {
                                kShowDialog(
                                 context: context,
                                  title: "Delete", 
                                  contentTxt: "Are you sure want to Delete?", 
                                  actionBtn1Txt: "Cancel", 
                                  actionBtn2Txt: 'Delete', 
                                  onPressed: ()async{
                                context.read<ServerMembersBloc>().add(DeleteServerEvent(serverId: serverId));
                                  kNavigationPushReplacement(context,const ScreenNavBar());
                                  }
                                  );
                               },
                               ); 

                  },
                ),
                kHeight15, 
              
              ],
            ),
          ),
        );
      },
    );
  }