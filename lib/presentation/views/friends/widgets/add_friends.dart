import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/presentation/views/friends/friends_bloc/friends_bloc.dart';
import 'package:crowd_verse/presentation/views/friends/widgets/public_userprofile_display.dart';
import 'package:crowd_verse/presentation/widgets/costum_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AddFriends extends StatelessWidget {
  const AddFriends({super. key});

  @override
  Widget build(BuildContext context) {
    context.read<FriendsBloc>().add(SearchAllUsersEvent(searchTxt:'')); 
    return Scaffold(  
      appBar:CustomAppBar(
        icon: Icons.arrow_back ,
        title: 'Add Friends',
        onPressed: () {
            context.read<FriendsBloc>().add(GetAllFriendsEvent()); 
           context.read<FriendsBloc>().add(PendingRequestsEvent());   
           Navigator.pop(context); 
        },
      ), 
      body: SizedBox( 
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),  
              child: CupertinoSearchTextField(
                onChanged: (value) {
                 context.read<FriendsBloc>().add(SearchAllUsersEvent(searchTxt:value)); 
                },
                padding: const EdgeInsets.all(10),
                backgroundColor: kClrLiteBlue,
                suffixIcon: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.grey,
                ),
                prefixIcon: const Icon( 
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded( 
              child: BlocBuilder<FriendsBloc, FriendsState>( 
                builder: (context, state) {
                  if (state is SearchAllUserLoadingState) {
                    return const ShimmerFriendsListTile(); 
                  }
                  if (state is SearchAllUserEmptyState) {
                    return  SizedBox(height: 200,width: 200, child: Lottie.network('https://lottie.host/6826a964-4a31-4504-b25c-8209c00869d4/8D2Vx9VYvn.json'));
                  }
                  if (state is SearchAllUserSuccessState) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = state.users[index];
                        return  ListTile(
                          onTap: () { 
                            kNavigationPush(context, PublicUserProfileDisplay(id:data.userId!,name: data.name!,));
                            context.read<FriendsBloc>().add(PublicUserProfileDisplayEvent(id:data.userId!)); 
                          },
                          leading:  CircleAvatar( 
                            radius: 30, 
                            backgroundImage:data.profilePhoto!=null?
                            NetworkImage(data.profilePhoto!):  
                            AssetImage(kDefaultProfilePic) as ImageProvider, 
                          ),
                          title: Text(data.name ??''), 
                          subtitle: Text(data.userName ??''),
  
                        );
                      }, 
                      separatorBuilder: (context, index) => const Divider(thickness: 0.2,), 
                      itemCount: state.users.length, 
                    );
                  }
                  return SizedBox(height: 200,width: 200, child: Lottie.network('https://lottie.host/fbc453e3-5f45-45e9-be22-99bafc600882/5IoE8V3TIm.json'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
