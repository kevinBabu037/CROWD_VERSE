
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/style.dart';
import 'package:crowd_verse/application/presentation/friends/friends_bloc/friends_bloc.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:crowd_verse/application/utils/core/images.dart';
import 'package:crowd_verse/application/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/application/presentation/friends/widgets/public_userprofile_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';


class FriendsList extends StatefulWidget {
  const FriendsList({super. key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  void initState() {
    context.read<FriendsBloc>().add(GetAllFriendsEvent());  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold( 
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
                   return  const Center(child: Text("No Friends Yet",style: kAppBarHedingStyke,),);
                  }                         
                  if (state is GetAllFriendsSuccsessState) {
                    return ListView.separated( 
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) { 
                        final data = state.friends[index]; 
                        
                        return ListTile( 
                            onTap: () {
                               kNavigationPush(context, PublicUserProfileDisplay(id: data.userId!, name:data.userName!));
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
                           trailing:  
          IconButton(onPressed: (){ 
            kShowDialog(   
              context: context, 
              title: 'Block User', 
              contentTxt: 'Are you sure want to block ${data.name}',
              actionBtn1Txt: 'Cancel', 
              actionBtn2Txt: 'Block', 
              onPressed: (){ 
               context.read<FriendsBloc>().add(BlockUserEvent(friendShipId:data.friendShipId!));
              Navigator.pop(context); 
            }); 
          }, 
           icon:const Icon(Icons.more_vert)), 
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
