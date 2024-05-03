
import 'package:crowd_verse/data/models/friends/friends_model.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/presentation/utils/core/style.dart';
import 'package:crowd_verse/presentation/views/friends/friends_bloc/friends_bloc.dart';
import 'package:crowd_verse/presentation/views/messages/message_bloc/bloc/friendly_message_bloc.dart';
import 'package:crowd_verse/presentation/views/messages/widgets/personal_chat.dart';
import 'package:crowd_verse/presentation/widgets/costum_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';


class ScreenMessages extends StatefulWidget {
  const ScreenMessages({super.key});

  @override
  State<ScreenMessages> createState() => _ScreenMessagesState();
}


class _ScreenMessagesState extends State<ScreenMessages> {
  @override 
  void initState() {
    context.read<FriendlyMessageBloc>().add(GetAllMessagesEvent(userId:'60'));
    context.read<FriendsBloc>().add(GetAllFriendsEvent());  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar:const CustomAppBar(title:'Messages'),
      body: Column(
        children: [         
          kHeight15,
          BlocListener<FriendsBloc, FriendsState>( 
            listener: (context, state) { 
               if (state is GetAllFriendsErrorState){
               const Center(child: Text("Error!!!")); 
            }
            }, 
            child: Expanded( 
              child: BlocBuilder<FriendsBloc, FriendsState>(
                builder: (context, state) {   
                   
                    if (state is GetAllFriendsLoadingState) {
                    return const Center(child: ShimmerFriendsListTile());     
                  }
                  if (state is GetAllFriendsEmptyState){ 
                   return  const Center(child: Text("No chat yet",style: kAppBarHedingStyke,),);
                  }                         
                  if (state is GetAllFriendsSuccsessState) {
                      
                    return ListView.separated( 
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) { 
                        FriendsModel data  = state.friends[index]; 
                        String time = kMessageTimeConverter(data.lastMsgTime!);
                        return ListTile( 
                            onTap: () {
                              kNavigationPush(context, PersonalChat(data: data,));
                            },
                          leading: InstaImageViewer(
                            child: CircleAvatar( 
                              radius: 30,
                              backgroundImage: data.profilePhoto != null
                                  ? NetworkImage(data.profilePhoto!)
                                  : AssetImage(kDefaultProfilePic) as ImageProvider, 
                            ),
                          ), 
                          title: Text(
                            data.name,
                            style: const TextStyle(fontSize: 18), 
                          ),
                          subtitle:data.lastMsg!=null? Text(data.lastMsg!,overflow: TextOverflow.ellipsis,) : Text(data.userName??''),
                          trailing: Text(time),
                          );
                      },
                      separatorBuilder: (context, index) =>      
                          const Divider(thickness: 0.1),
                      itemCount: state.friends.length,
                    );
                  } 
                  return const Center(child: Text(''));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
