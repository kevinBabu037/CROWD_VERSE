import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/presentation/utils/core/style.dart';
import 'package:crowd_verse/presentation/utils/validations/validation.dart';
import 'package:crowd_verse/presentation/views/friends/friends_blc/friends_bloc.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingRequests extends StatefulWidget { 
  const PendingRequests({super.key});

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  @override
  void initState() {
    context.read<FriendsBloc>().add(PendingRequestsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     
    return  Scaffold(
      body:  BlocBuilder<FriendsBloc, FriendsState>(
        builder: (context, state) {
          if (state is PendingFriendsLoadingState) {
            return const ShimmerFriendsListTile();
          }
          if (state is PendingFriendsEmptyState) {
            return const Center(child: Text('empty',style: kAppBarHedingStyke,),);
          }

          if (state is PendingFriendsSuccessState) { 
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
                            data.name!,    
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
                                            text: ' Remove Request ',   
                                            onPressed: () {  
                                            context.read<FriendsBloc>().add(RemoveFromPendingrequestsEvent(friendshipId: data.friendShipId!));
                                          }, ); 
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
          return const Center(child: Text('fail to fetch'),); 
        },
      )
    );
  }
}