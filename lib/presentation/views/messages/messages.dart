
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/presentation/utils/core/style.dart';
import 'package:crowd_verse/presentation/views/friends/friends_bloc/friends_bloc.dart';
import 'package:crowd_verse/presentation/views/messages/widgets/personal_chat.dart';
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
  Widget build(BuildContext context) {
    context.read<FriendsBloc>().add(GetAllFriendsEvent());  

    return Scaffold( 
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Messages',style: kAppBarHedingStyke,),
      ),
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
                        final data = state.friends[index]; 
    
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
                          subtitle: Text("${data.userName}"),               
        
                        ); 
                      },
                      separatorBuilder: (context, index) =>     
                          const Divider(thickness: 0.1),
                      itemCount: state.friends.length,
                    );
                  } 
                  return const Center(child: Text('Fail to Fetch'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
