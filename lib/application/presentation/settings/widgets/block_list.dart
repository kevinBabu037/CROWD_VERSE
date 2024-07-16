import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/images.dart';
import 'package:crowd_verse/application/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/application/utils/core/style.dart';
import 'package:crowd_verse/application/presentation/friends/friends_bloc/friends_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class BlockList extends StatefulWidget {
  const BlockList({super.key});

  @override 
  State<BlockList> createState() => _BlockListState();
}

class _BlockListState extends State<BlockList> {
  @override
  void initState() {
    context.read<FriendsBloc>().add(GetAllBlockListEvent()); 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Block List'),
      ),
      body: BlocBuilder<FriendsBloc, FriendsState>(
        builder: (context, state) {
          if (state is GetAllBlockListLoadingState) {
            return const ShimmerFriendsListTile();
          }
          if (state is GetAllBlockListEmptyState) {
            return const Center(child: Text('empty',style:kAppBarHedingStyke,),);
          } 
        if (state is GetAllBlockListSuccsessState) {
         return ListView.separated( 
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) { 
                              final data = state.blockLst[index];  
                              return ListTile( 
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
                    title: 'Un Block',  
                    contentTxt: 'Are you sure want to Unbloc ${data.name}', 
                    actionBtn1Txt: 'Cancel', 
                    actionBtn2Txt: 'UnBlock', 
                    onPressed: (){    
                    context.read<FriendsBloc>().add(UnBlockUser(friendShipId: data.friendShipId!));
                    context.read<FriendsBloc>().add(GetAllBlockListEvent());
                    Navigator.pop(context); 
                  }); 
      
                },
                 icon:const Icon(Icons.more_vert)), 
              
                              ); 
                            },
                            separatorBuilder: (context, index) =>     
                                const Divider(thickness: 0.1),
                            itemCount: state.blockLst.length,
                          );
        } 
        return const Center(child: Text('fail to fech'),);
        },
      ),
    );
  }
}