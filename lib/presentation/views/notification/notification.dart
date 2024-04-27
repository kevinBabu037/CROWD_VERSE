
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/presentation/utils/core/style.dart';
import 'package:crowd_verse/presentation/views/friends/friends_bloc/friends_bloc.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/validations/validation.dart';

class ScreenNotification extends StatelessWidget {
  const ScreenNotification({super.key});

   @override 
  Widget build(BuildContext context) {
    context.read<FriendsBloc>().add(GetAllFriendRequestsEvent());    
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        title:const Text('Notifications',style: kAppBarHedingStyke,),
      ),
      body: BlocListener<FriendsBloc, FriendsState>(  
        listener: (context, state) {          
             if(state is GetAllFriendRequestsErrorState){ 
                const Center(child: Text("error"),);
            }            
        },  
        child: BlocBuilder<FriendsBloc, FriendsState>( 
              builder: (context, state) { 
                if (state is GetAllFriendRequestsEmptyState){
                return const Center(child: Text('Empty',style: kAppBarHedingStyke,),); 
                }  
                 if (state is GetAllFriendsLoadingState) {  
                    return const Center(child: ShimmerFriendsListTile());  
                  }
                if (state is GetAllFriendRequestsSuccesstate){ 
                  return ListView.separated(  
                                  itemBuilder: (context, index){ 
                                    
                                    final data = state.friends[index];
                                  final date = calculateTimeDifference(data.time!);   
                                    
                                    return ListTile(  
                                      leading: CircleAvatar(  
                                        radius: 30,   
                                        backgroundImage: data.profilePhoto != null
                                            ? NetworkImage(data.profilePhoto!)
                                            : AssetImage(kDefaultProfilePic) as ImageProvider, 
                                      ),
                                      title: Text(
                                        "${data.userName} sent you a friend request.",  
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      subtitle:SizedBox(
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [ 
                                              SizedBox(
                                                height: 26,
                                                child: BlocBuilder<FriendsBloc, FriendsState>(
                                                  builder: (context, state) {
                                                    return LoginSignUpButtonWidget(
                                                        fontSize: 14, 
                                                        clr:kClrGreyLight,  
                                                        text: '  Ignore  ', 
                                                        onPressed: () {
                                                       context.read<FriendsBloc>().add(RejectttRequestEvent(friendshipId:data.friendShipId! , acceptOrReject:'reject'));
                                                      }, );
                                                  },
                                                ), 
                                              ), 
                                              SizedBox(
                                                height: 26,   
                                                child: BlocBuilder<FriendsBloc, FriendsState>(
                                                  builder: (context, state){
                                                    return LoginSignUpButtonWidget(
                                                      fontSize: 14, 
                                                      text: '  Accept  ',
                                                      onPressed: () {
                                                      context.read<FriendsBloc>().add(AccepttRequestEvent(friendshipId: data.friendShipId!, acceptOrReject: 'accept'));
                                                    },);
                                                  },
                                                ),
                                              ),
                                             const Spacer(), 
                                             Text(date,style:const TextStyle(color:kClrGrey),)
                                            ],
                                          ),
                                        ),
                                      ), 
                                      
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(thickness: 0.2),
                                  itemCount: state.friends.length,
                                );
                } 
                return const SizedBox(); 
              },
            ),
      )
    );
  }
}
