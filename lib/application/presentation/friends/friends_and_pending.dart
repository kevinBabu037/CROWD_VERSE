import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/style.dart';
import 'package:crowd_verse/application/presentation/friends/widgets/add_friends.dart';
import 'package:crowd_verse/application/presentation/friends/widgets/friends_list.dart';
import 'package:flutter/material.dart';

import 'widgets/pending_requests.dart';


class FriendsAndPending extends StatelessWidget {
  const FriendsAndPending({super.key});

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: PreferredSize(preferredSize:const Size.fromHeight(90), 
          child: AppBar(
            actions: [
                  GestureDetector(
            onTap: () {
              kNavigationPush(context,const AddFriends());   
            }, 
            child:const Text('Add Friends  ',
            style: TextStyle(fontSize: 17 ,color:kClrBlue),
            ))
            ],
            centerTitle: true,
            title: const Text('Friends',style: kAppBarHedingStyke),           
              bottom: TabBar(
                labelColor: kClrBlack,
                unselectedLabelColor: kClrBlue, 
                labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)
                ),
                tabs:const[
                Tab(child: Text('Your Friends',   
                ) ,),
               Tab( child:Text("Pending", 
               style: TextStyle(fontWeight: FontWeight.bold),
               ),)
              ] ), 
          )
          ),
          body:const TabBarView(
            children: [
            FriendsList(),
            PendingRequests()  
            ]
          ) 
      ),
    );
  }
}